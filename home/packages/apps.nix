{
  pkgs ? import <nixpkgs> { },
  zen-browser ? import <nixpkgs> { },
}:

with pkgs;
[
  # arduino-ide
  caprine
  # fragments # Bittorrent client
  gnome-frog
  # vial
  youtube-music
  zen-browser.default
]
