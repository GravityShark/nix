#!/bin/sh
tmux split-window -v -l 5
tmux send-keys "nix-shell --command \"z scripts/; ./tailwindcss.sh --watch\"" Enter
tmux select-pane -t :.+
tmux send-keys "nix-shell --command \"air\"" Enter
tmux new-window
tmux send-keys "v" Enter
