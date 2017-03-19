#!/bin/sh

tmux has-session -t serverchef || tmux new-session -d -s serverchef
export TERM=xterm-256color 
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
gotty -w -a 127.0.0.1 -p 59764 tmux attach -t serverchef
