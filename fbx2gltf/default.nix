{ fetchurl, stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "fbx2gltf";
  version = "0.9.7";

  buildPhase = ":";

  src = fetchurl {
    url = "https://github.com/facebookincubator/${pname}/releases/download/v${version}/${pname}-linux-x64";
    hash = "sha256-s4IQNS/dKdULpTplFMP/Bcy7XR4KZELbekmDS/NKMUU=";
  };

  libPath = lib.makeLibraryPath [
    stdenv.cc.cc
  ];

  unpackPhase = ":";

  installPhase = ''
    runHook preInstall

    install -D "$src" "$out/bin/$pname"
    patchelf --set-interpreter "$(< $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath $libPath \
      "$out/bin/$pname"
  '';

  fixupPhase = ":";

  meta = with lib; {
    description = "A command line tool for converting 3D model assets on FBX format to glTF 2.0";
    homepage = "https://github.com/facebookincubator/fbx2gltf";
    license = licenses.bsd2;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
