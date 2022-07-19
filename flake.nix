{
  inputs = {
    nixpkgs.url = "github:peperunas/nixpkgs/llvm-i686-cross-fix";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        localSystem = { inherit system; };
        crossSystem = {
          config = "i686-unknown-linux-gnu";
        };
        pkgs = import nixpkgs {
          inherit localSystem crossSystem;
          overlays = [
            (self: super: {
              zlib =
                if super.stdenv.hostPlatform != super.stdenv.buildPlatform then
                  super.zlib.overrideAttrs (_: {
                    version = "1.2.11";
                    src = builtins.fetchurl {
                      url = "https://www.zlib.net/fossils/zlib-1.2.11.tar.gz";
                      sha256 =
                        "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1";
                    };
                  })
                else
                  super.zlib;
            })
          ];
        };
      in rec {
        defaultPackage =
          pkgs.callPackage ./pkg.nix { stdenv = pkgs.clangStdenv; };
        packages = flake-utils.lib.flattenTree { librop = defaultPackage; };
      });
}
