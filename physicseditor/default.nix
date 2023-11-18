{ stdenv, lib, qt5, fetchurl }:

stdenv.mkDerivation rec {
  name = "physicseditor-${version}";
  version = "1.6.4";

  src = fetchurl {
    url = "https://cdn.codeandweb.com/download/physicseditor/1.6.4/PhysicsEditor-1.6.4-ubuntu64.deb";
    sha256 = "1rzzj39b4clrxsha94i0w8jf9jcg780lcmv1gr1xs89sdyvi3w31";
  };
  sourceRoot = ".";
  unpackCmd = ''
    ar p "$src" data.tar.xz | tar xJ
  '';

  buildPhase = ":";   # nothing to build

  installPhase = ''
    mkdir -p $out/bin
    cp -R usr/* $out/
    # fix the path in the desktop file
    # substituteInPlace \
    #   $out/share/applications/masterpdfeditor4.desktop \
    #   --replace /opt/ $out/opt/
    # symlink the binary to bin/
    # ln -s $out/opt/master-pdf-editor-4/masterpdfeditor4 $out/bin/masterpdfeditor4
  '';
  preFixup = let
    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
    libPath = lib.makeLibraryPath [
      qt5.qtbase        # libQt5PrintSupport.so.5
      qt5.qtsvg         # libQt5Svg.so.5
      stdenv.cc.cc.lib  # libstdc++.so.6
    ];
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}" \
      $out/bin/PhysicsEditor
  '';

  meta = with lib; {
    homepage = "https://www.codeandweb.com/physicseditor";
    description = "Edit your collision shapes for Box2d, Chipmunk, Ninja, P2, Arcade";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
  };
}
