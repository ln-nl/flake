{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "http-server";
  version = "14.1.1";

  src = fetchFromGitHub {
    owner = "http-party";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-M/YC721QWJfz5sYX6RHm1U9WPHVRBD0ZL2/ceYItnhs=";
  };

  npmDepsHash = "sha256-I7KIkl781reNqd4gnqQ1loCm9nZZMqMMjul+pRiI7DE=";

  # unpackPhase = ''
  #   mv npm-shrinkwrap.json package-lock.json
  # '';

  # dontNpmBuild = true;

  # patches = [ ./package-lock.patch ];

  # NODE_OPTIONS = "--openssl-legacy-provider";

  meta = with lib; {
    description = "A simple zero-configuration command-line http server ";
    homepage = "https://github.com/http-party/http-server";
    license = licenses.mit;
  };
}
