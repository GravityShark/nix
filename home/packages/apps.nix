{ pkgs, zen-browser }:

with pkgs;
[
  anki
  normcap # better OCR
  # teams-for-linux
  vial
  youtube-music
  zen-browser.default # might want to try other browser
]
