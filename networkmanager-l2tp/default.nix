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
, gtk3
, networkmanager
, ppp
, xl2tpd
, libreswan
, libsecret
, libnma
, glib
, withGnome ? true
}:

stdenv.mkDerivation rec {
  name = "${pname}${if withGnome then "-gnome" else ""}-${version}";
  pname = "NetworkManager-l2tp-modp1024";
  version = "1.2.12";

  src = fetchFromGitHub {
    owner = "nm-l2tp";
    repo = "NetworkManager-l2tp";
    rev = version;
    sha256 = "sha256-pKIlTj85uNF/IcaePQ8YoyMXLa5/KEKPQhqlSvc8ADM=";
  };

  patches = [
    (substituteAll {
      src = ./fix-paths.patch;
      inherit libreswan xl2tpd;
    })
  ];

  buildInputs = [ networkmanager ppp glib ]
    ++ lib.optionals withGnome [ gtk3 libsecret libnma ];

  nativeBuildInputs = [ autoreconfHook libtool intltool pkg-config file findutils ];

  preConfigure = ''
    intltoolize -f
  '';

  configureFlags = [
    "--without-libnm-glib"
    "--with-gnome=${if withGnome then "yes" else "no"}"
    "--localstatedir=/var"
    "--sysconfdir=$(out)/etc"
    "--enable-absolute-paths"
    # For use with libreswan < 3.30 or libreswan packages built with
    # USE_DH2=true i.e. have modp1024 support.
    "--enable-libreswan-dh2"
  ];

  enableParallelBuilding = true;

  passthru = {
    networkManagerPlugin = "VPN/nm-l2tp-service.name";
  };

  meta = with lib; {
    description = "L2TP plugin for NetworkManager";
    inherit (networkmanager.meta) platforms;
    homepage = "https://github.com/nm-l2tp/network-manager-l2tp";
    license = licenses.gpl2;
    maintainers = with maintainers; [ abbradar obadz ];
  };
}
