{ pkgs }:

with pkgs;
[
  mcontrolcenter # MSI
  obsidian # r7l overlay
  qbittorrent

  # File viewer
  vlc # Videos + Music
  zathura # Documents

  # Media creation
  # audacity
  # gnome-sound-recorder
  # kdePackages.kdenlive # Video editor (I should enable gpu when using this)
  krita # Drawing

  # School
  onlyoffice-desktopeditors
  pdfarranger
  # telegram-desktop
  # zoom-us
]
