{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config = {
          allowUnfree = true;
        };
      };
    in
    rec {

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

        flashback = (
          import ./flashback/Cargo.nix {
            inherit pkgs;
          }
        ).rootCrate.build;

        flashplayer-standalone-debugger = import ./flashplayer/standalone.nix {
          inherit (pkgs) stdenv lib fetchurl alsaLib atk bzip2 cairo curl
            expat fontconfig freetype gdk-pixbuf glib glibc graphite2 gtk2
            harfbuzz libdrm libffi libglvnd libpng libvdpau nspr nss pango
            pcre pixman zlib unzip;

          inherit (pkgs.xorg) libICE libSM libX11 libXau libXcomposite
            libXcursor libXrender libXt libXxf86vm libxcb libxshmfence
            libXdamage libXdmcp libXext libXfixes libXi libXinerama libXrandr;
        };

        libreswan = import ./libreswan {
          inherit (pkgs) lib stdenv fetchurl nixosTests pkg-config systemd gmp
            unbound bison flex pam libevent libcap_ng libxcrypt curl nspr bash runtimeShell iproute2
            iptables procps coreutils gnused gawk nss which python3 libselinux
            ldns xmlto docbook_xml_dtd_412 docbook_xsl findXMLCatalogs;
        };

        networkmanager-l2tp = import ./networkmanager-l2tp {
          inherit (pkgs) lib stdenv substituteAll fetchFromGitHub
            autoreconfHook libtool intltool pkg-config file findutils gtk3
            networkmanager ppp xl2tpd libsecret libnma glib;

          inherit (packages.x86_64-linux) libreswan;
        };

        nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          exec "$@"
        '';

        nodePackages = import ./node-packages {
          inherit (pkgs) system stdenv lib;
          inherit pkgs;
        };

        texturepacker = import ./texturepacker {
          inherit (pkgs) stdenv dpkg fetchurl autoPatchelfHook;
          inherit (pkgs.qt6) qtwayland;
        };

        videoshot = import ./videoshot {
          inherit (pkgs) wf-recorder slurp libnotify coreutils bash resholve;
        };

        yo = import ./yo {
          inherit (pkgs) lib buildNpmPackage fetchFromGitHub;
        };

      };

    };
}
