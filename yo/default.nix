{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "yo";
  version = "4.3.1";

  src = fetchFromGitHub {
    owner = "yeoman";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-vnvcg3hvAYcqS11enBEHtpTwTOy4puY5i/6zPOHCywo=";
  };

  npmDepsHash = "sha256-QkEPaepvI6NfEEmqnVA4Xx/tByn6goyGWVpoJNMigd8=";

  dontNpmBuild = true;

  meta = with lib; {
    description = "CLI tool for running Yeoman generators";
    homepage = "https://yeoman.io/";
    license = licenses.bsd2;
  };
}
