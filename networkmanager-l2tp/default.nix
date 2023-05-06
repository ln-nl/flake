{ lib
, stdenv
, substituteAll
, fetchFromGitHub
, autoreconfHook
, libtool
, intltool
, pkg-config
, file
, findutils
, glib
, gtk3
, gtk4
, libnma
, libnma-gtk4
, libreswan
, libsecret
, networkmanager
, openssl
, ppp
, nss
, xl2tpd
, withGnome ? true
}:

stdenv.mkDerivation rec {
  name = "${pname}${if withGnome then "-gnome" else ""}-${version}";
  pname = "NetworkManager-l2tp-modp1024";
  version = "1.20.10";

  src = fetchFromGitHub {
    owner = "nm-l2tp";
    repo = "NetworkManager-l2tp";
    rev = version;
    sha256 = "sha256-EfWvh4uSzWFadZAHTqsKa3un2FQ6WUbHLoHo9gSS7bE=";
  };

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      inherit libreswan xl2tpd;
    })
  ];

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];

  buildInputs = [
    networkmanager
    ppp
    glib
    openssl
    nss
  ] ++ lib.optionals withGnome [
    gtk3
    gtk4
    libsecret
    libnma
    libnma-gtk4
  ];

  configureFlags = [
    "--with-gnome=${if withGnome then "yes" else "no"}"
    "--with-gtk4=${if withGnome then "yes" else "no"}"
    "--localstatedir=/var"
    "--enable-absolute-paths"
    # For use with libreswan < 3.30 or libreswan packages built with
    # USE_DH2=true i.e. have modp1024 support.
    # "--enable-libreswan-dh2"
  ];

  enableParallelBuilding = true;

  passthru = {
    networkManagerPlugin = "VPN/nm-l2tp-service.name";
  };

  meta = with lib; {
    description = "L2TP plugin for NetworkManager";
    inherit (networkmanager.meta) platforms;
    homepage = "https://github.com/nm-l2tp/network-manager-l2tp";
    license = licenses.gpl2Plus;
    maintainers = with maintainers; [ abbradar obadz ];
  };
}
