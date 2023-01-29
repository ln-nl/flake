{ stdenv
, autoPatchelfHook
, dpkg
, fetchurl
, qtwayland
}:

stdenv.mkDerivation rec {
  pname = "texturepacker";
  version = "6.0.2";

  src = fetchurl {
    url = "https://www.codeandweb.com/download/texturepacker/${version}/TexturePacker-${version}.deb";
    hash = "sha256-Ur45HLr1NK2NpCPKS0cYgwtNPZYogvEWUmw02JiCZv8=";
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
