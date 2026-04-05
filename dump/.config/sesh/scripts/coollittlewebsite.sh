#!/bin/sh
# tmux split-window -v -l 5
tmux split-window -h
tmux send-keys "nix-shell --command \"cd web/ ./build/tailwindcss.sh --watch\"" Enter
tmux select-pane -t :.+
tmux send-keys "nix-shell --command \"air\"" Enter
tmux new-window
tmux send-keys "v" Enter
