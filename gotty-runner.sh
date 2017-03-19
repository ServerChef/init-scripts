#!/bin/sh

su -c '
printenv

echo "Ensuring that session exists"
tmux has-session -t serverchef || tmux new-session -d -s serverchef

echo "Starting gotty process"
export TERM=xterm-256color
gotty -w -a 127.0.0.1 -p 59764 tmux new-session -A -s serverchef
' - $(whoami)
