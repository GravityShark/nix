{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
[
  # arduino-ide
  # authenticator
  caprine
  # fragments # Bittorrent client
  gnome-frog
  # vial
  youtube-music
  zen-browser.default
]
