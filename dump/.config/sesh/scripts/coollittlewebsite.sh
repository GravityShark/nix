#!/bin/sh
# tmux split-window -v -l 5

tmux send-keys "nix-shell --command \"v\"" Enter

tmux new-window
tmux send-keys "nix-shell" Enter

tmux new-window
tmux split-window -h
tmux send-keys "nix-shell --command \"cd web/; ./build/tailwindcss.sh --watch\"" Enter
tmux select-pane -t :.+
tmux send-keys "nix-shell --command \"air\"" Enter
