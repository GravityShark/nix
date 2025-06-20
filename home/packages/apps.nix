{ pkgs, zen-browser }:

with pkgs;
[
  # arduino-ide
  caprine-bin
  # fragments # Bittorrent client
  qbittorrent
  gnome-frog
  # vial
  youtube-music
  zen-browser.default
]
