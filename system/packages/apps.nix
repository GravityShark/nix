{ pkgs }:

with pkgs;
[
  emacs
  ghostty # Terminal
  mcontrolcenter # MSI

  # File viewer
  evince # Documents
  foliate # Epub
  vlc # Videos + Music

  # Media creation
  gnome-sound-recorder
  # kdePackages.kdenlive # Video editor (I should enable gpu when using this)
  krita # Drawing

  # School
  onlyoffice-desktopeditors
  telegram-desktop
  zoom-us
]
