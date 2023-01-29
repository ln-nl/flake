{ lib, buildNpmPackage, fetchFromGitHub }:

buildNpmPackage rec {
  pname = "firebase-tools";
  version = "11.16.0";

  src = fetchFromGitHub {
    owner = "firebase";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-5T7jR5beKYBCVTpOvLSWWzols8GIPCuJ7pDN018IDKg=";
  };

  npmDepsHash = "sha256-q9PG1gE11eE19iT0egumgnJPgpmy2vhCov0lf4+Ld7E=";

  unpackPhase = ''
    mv npm-shrinkwrap.json package-lock.json
  '';

  # dontNpmBuild = true;

  # patches = [ ./package-lock.patch ];

  # NODE_OPTIONS = "--openssl-legacy-provider";

  meta = with lib; {
    description = "Jukebox/Howler/CreateJS compatible audio sprite generator";
    homepage = "https://flood.js.org";
    license = licenses.gpl3Only;
  };
}
