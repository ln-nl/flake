{ fetchurl, stdenv, lib, unzip }:

stdenv.mkDerivation rec {
  pname = "reason-language-server-bin";
  version = "1.5.2";

  nativeBuildInputs = [ unzip ];

  buildPhase = ":";
  
  src = fetchurl {
    url = "https://github.com/jaredly/reason-language-server/releases/download/${version}/linux.zip";
    sha256 = "1qclb8dirm84znlh3nnzlx5h3l03ydrhbfxpfb64hxgx674jw69k";
  };
  
  installPhase = ''
    mkdir -p $out/bin
    cp reason-language-server.exe "$out/bin/reason-language-server"
  '';
  
  fixupPhase = ":";

  meta = with lib; {
    description = "Language Server Protocol for reason";
    homepage = "https://github.com/jaredly/reason-language-server";
    license = licenses.isc;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux;
  };
}
