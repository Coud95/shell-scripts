#!/bin/bash
cover=$(find . -name cover\*)
if [ -z "$cover" ]
then
      setsid -f mpv --geometry=25% --vid=1 .
else
      setsid -f mpv --geometry=25% --external-file=$cover --vid=1 .
fi
