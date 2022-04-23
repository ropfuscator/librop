{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/4b675777";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pkgs32 = pkgs.pkgsi686Linux;
      in rec {
        defaultPackage = pkgs32.callPackage ./pkg.nix {
          stdenv = pkgs32.clangStdenv;
        };
        packages = flake-utils.lib.flattenTree { librop = defaultPackage; };
      });
}
