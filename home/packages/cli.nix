{ pkgs }:

with pkgs;
[
  # appimage-run
  doas-sudo-shim
  nix-your-shell
  sesh
  # tomato-c # find something better
  xdg-terminal-exec
]
