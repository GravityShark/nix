{ config, pkgs, ... }:

{
  mime.enable = true;

  apps = {
    desktop.enable = true;
    dev.enable = true;
    fish.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    neovim.enable = true;
    nixcraft.enable = true;
    syncthing.enable = true;
    tmux.enable = true;
    zen-browser.enable = true;
  };

  desktop = {
    niri.enable = true;
    noctalia.enable = true;
    stylix = {
      enable = true;
      theme = "gruvbox-material-light";
    };
  };

  service = {
    notes-backup.enable = true;
    keepassxc.enable = true;
    swayidle.enable = true;
  };

  ####### Extra shit
  home.file = {
    ".mkshrc".source = ../../dump/.mkshrc;
    ".scripts".source = ../../dump/.scripts;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.scripts"
    "${config.home.homeDirectory}/.scripts/aliases"
  ];

  xdg.configFile = {
    "fastfetch".source = ../../dump/.config/fastfetch;
    "xdg-terminals.list".source = ../dump/.config/xdg-terminals.list;
  };

  home.packages = with pkgs; [
    qbittorrent
    # selectdefaultapplication
    super-productivity
    vial
    xdg-terminal-exec
    youtube-music

    ## File viewer
    vlc # Videos + Music

    ## Media
    # audacity
    # gnome-sound-recorder
    kdePackages.kdenlive # Video editor (I should enable gpu when using this)
    krita # Drawing
    # obsidian

    ## School
    onlyoffice-desktopeditors
    pdfarranger
    # teams-for-linux
    # telegram-desktop
    # zoom-us

    git

    ## CLIs
    bc
    doas-sudo-shim
    # efibootmgr
    fastfetch
    ffmpeg

    ## Wine
    # bubblewrap
    # dwarfs
    # fuse-overlayfs
    wineWowPackages.staging
  ];

  programs = {
    anki.enable = true;
    anki.answerKeys = [
      {
        ease = 1;
        key = "x";
      }
      {
        ease = 3;
        key = "c";
      }
    ];
    vesktop.enable = true;
    zathura.enable = true;
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
