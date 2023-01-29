{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "audiosprite";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "tonistiigi";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-HV/euX9l8k6abgKPYR6jkRNQru5RNfnMZOMYhlOmQxA=";
  };

  npmDepsHash = "sha256-q9PG1gEWueE19iT0egumgnJPgpmy2vhCov0lf4+Ld7E=";

  dontNpmBuild = true;

  patches = [ ./package-lock.patch ];

  # NODE_OPTIONS = "--openssl-legacy-provider";

  meta = with lib; {
    description = "Jukebox/Howler/CreateJS compatible audio sprite generator";
    homepage = "https://github.com/tonistiigi/audiosprite";
    license = licenses.mit;
  };
}
