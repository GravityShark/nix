{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
[
  # discord-canary
  emacs
  ghostty # Terminal
  keepassxc # Passwords
  mcontrolcenter # MSI

  # File viewer
  evince # Documents
  foliate # Epub
  mpv # Video

  # Media creation
  gnome-sound-recorder
  # kdePackages.kdenlive # Video editor (I should enable gpu when using this)
  krita # Drawing

  # School
  anki
  libreoffice-fresh # Basic office utilities
  telegram-desktop
  zoom-us
]
