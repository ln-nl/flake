{ resholve, wf-recorder, slurp, libnotify, coreutils, bash }:

resholve.mkDerivation {
  pname = "videoshot";
  version = "0.1.0";

  src = ./.;

  dontUnpack = true;
  installPhase = ''
    install -D $src/videoshot.sh $out/bin/videoshot
  '';

  solutions = {
    videoshot = {
      scripts = [ "bin/videoshot" ];
      interpreter = "${bash}/bin/bash";
      inputs = [ wf-recorder slurp libnotify coreutils bash ];
    };
  };
}
