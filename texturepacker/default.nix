{ stdenv
, autoPatchelfHook
, dpkg
, fetchurl
, qtwayland
}:

stdenv.mkDerivation rec {
  pname = "texturepacker";
  version = "7.0.3";

  src = fetchurl {
    url = "https://www.codeandweb.com/download/texturepacker/${version}/TexturePacker-${version}.deb";
    hash = "sha256-VAGdMUbGIDG744fdzLtkDiFUme4cI6r44yTZ/sSLqCY=";
  };

  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
  ];

  buildInputs = [
    qtwayland
  ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out
    dpkg -x $src $out
    mv -v $out/usr/* $out
    rm -rf $out/usr
  '';

  dontPatchELF = true;
  dontStrip = true;
  dontWrapQtApps = true;
}
