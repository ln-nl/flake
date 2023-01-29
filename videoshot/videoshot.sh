#!/usr/bin/env bash

readonly VIDEOSHOTDIR="$HOME/Videos"

if [[ ! -e $VIDEOSHOTDIR ]]; then
  mkdir -p "$VIDEOSHOTDIR"
fi

readonly PIDPATH="$VIDEOSHOTDIR/videoshot.pid"
readonly RESOURCEPATH="$VIDEOSHOTDIR/videoshot.txt"

if [[ ! -f "$PIDPATH" ]]; then
  readonly FILENAME="$(date +'%Y-%m-%d-%H%M%S_wf-recorder.mp4')"
  readonly VIDPATH="$VIDEOSHOTDIR/$FILENAME"
  (
    wf-recorder -g "$(slurp)" -f "$VIDPATH" $@ &
    echo "$!" >"$PIDPATH"
    echo "$VIDPATH" >"$RESOURCEPATH"
    # notify-send "Start recording" "$VIDPATH"
    readonly PID="$(cat $PIDPATH)"
    wait "$PID"
    readonly VIDPATH="$(cat $RESOURCEPATH)"
    if [ ! -f "$VIDPATH" ]; then
      notify-send "Recording aborted"
    fi
    rm "$PIDPATH"
    rm "$RESOURCEPATH"
  ) &
else
  readonly PID="$(cat $PIDPATH)"
  kill -SIGINT "$PID"
fi
