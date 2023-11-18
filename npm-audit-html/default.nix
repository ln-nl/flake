{ lib
, buildNpmPackage
, fetchFromGitHub
}:

buildNpmPackage rec {
  pname = "npm-audit-html";
  version = "2.0.0-beta.2";

  src = fetchFromGitHub {
    owner = "eventOneHQ";
    repo = "npm-audit-html";
    rev = "588b2bf18e4d30d51b5832f8237650b4c9f2d5b8";
    hash = "sha256-qFYaDj4gUy+p397qQLeKZpIt+GwKxbYCMQJwUtnq9hE=";
  };

  npmDepsHash = "sha256-uuw7NVAMpQ5EVm/PcZWHDPQ71MocN8wZ8XZnNei5FC0=";

  meta = {
    description = "Generate a HTML report for NPM Audit";
    homepage = "https://github.com/eventOneHQ/npm-audit-html";
    license = lib.licenses.mit;
    mainProgram = "npm-audit-html";
    maintainers = with lib.maintainers; [ ];
  };
}
