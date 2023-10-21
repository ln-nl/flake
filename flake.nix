{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
      };
    };
  in rec {
    packages.x86_64-linux = {
      audiosprite = import ./audiosprite {
        inherit (pkgs) lib buildNpmPackage fetchFromGitHub;
      };

      fbx2gltf = import ./fbx2gltf {
        inherit (pkgs) fetchurl stdenv lib;
      };

      http-server = import ./http-server {
        inherit (pkgs) lib buildNpmPackage fetchFromGitHub;
      };

      flashback =
        (
          import ./flashback/Cargo.nix {
            inherit pkgs;
          }
        )
        .rootCrate
        .build;

      flashplayer-standalone-debugger = import ./flashplayer/standalone.nix {
        inherit
          (pkgs)
          stdenv
          lib
          fetchurl
          alsaLib
          atk
          bzip2
          cairo
          curl
          expat
          fontconfig
          freetype
          gdk-pixbuf
          glib
          glibc
          graphite2
          gtk2
          harfbuzz
          libdrm
          libffi
          libglvnd
          libpng
          libvdpau
          nspr
          nss
          pango
          pcre
          pixman
          zlib
          unzip
          ;

        inherit
          (pkgs.xorg)
          libICE
          libSM
          libX11
          libXau
          libXcomposite
          libXcursor
          libXrender
          libXt
          libXxf86vm
          libxcb
          libxshmfence
          libXdamage
          libXdmcp
          libXext
          libXfixes
          libXi
          libXinerama
          libXrandr
          ;
      };

      nodePackages = import ./node-packages {
        inherit (pkgs) system stdenv lib;
        inherit pkgs;
      };

      texturepacker = import ./texturepacker {
        inherit (pkgs) stdenv dpkg fetchurl autoPatchelfHook;
        inherit (pkgs.qt6) qtwayland;
      };

      yo = import ./yo {
        inherit (pkgs) lib buildNpmPackage fetchFromGitHub;
      };
    };
  };
}
