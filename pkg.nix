{ stdenv, cmake, python3 }:

stdenv.mkDerivation {
  pname = "librop";
  version = "1.0.0";
  nativeBuildInputs = [ cmake python3 ];
  src = ./.;
  postPatch = "patchShebangs .";
}
