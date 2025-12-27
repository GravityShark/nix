{ pkgs }:

with pkgs;
[
  super-productivity
  # teams-for-linux
  vial
  youtube-music

  mcontrolcenter # MSI
  qbittorrent

  ## File viewer
  vlc # Videos + Music
  # zathura # Documents

  ## Media
  # audacity
  # gnome-sound-recorder
  # kdePackages.kdenlive # Video editor (I should enable gpu when using this)
  krita # Drawing

  ## School
  onlyoffice-desktopeditors
  pdfarranger
  # telegram-desktop
  # zoom-us

  ## CLIs
  # bc
  # dash
  efibootmgr
  eza
  fastfetch
  fd
  ffmpeg
  # fish
  # fzf
  ghostscript_headless
  git
  imagemagick
  # neovim
  restic
  ripgrep
  tmux
  unzip
  zoxide

  ## Dev
  clang
  gnumake
  go
  # nodejs
  python3
]
