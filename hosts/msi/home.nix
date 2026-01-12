{ config, pkgs, ... }:

{
  mime.enable = true;

  desktop = {
    niri.enable = true;
    noctalia.enable = true;
    stylix = {
      enable = true;
      # theme = "rose-pine";
      theme = "gruvbox-material-light";
    };
  };

  apps = {
    desktop.enable = true;
    dev.enable = true;
    fish.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    minecraft.enable = true;
    neovim.enable = true;
    syncthing.enable = true;
    tmux.enable = true;
    zen-browser.enable = true;
  };

  service = {
    notes-backup.enable = true;
    keepassxc.enable = true;
    swayidle.enable = true;
  };

  home.stateVersion = "25.11"; # Read Home Manager release notes when changing.

  ################################## Extra ###################################

  home.packages = with pkgs; [
    ## Apps
    (callPackage ../../home/apps/packages/caprine-ng-bin.nix { })
    easyeffects
    # obsidian
    # qbittorrent
    # selectdefaultapplication
    super-productivity
    # vial
    vlc # Videos + Music
    youtube-music

    ## Media
    # audacity
    gnome-sound-recorder
    kdePackages.kdenlive # Video editor (I should enable gpu when using this)
    krita # Drawing

    ## School
    onlyoffice-desktopeditors
    pdfarranger
    # teams-for-linux
    # telegram-desktop
    # zoom-us

    ## CLIs
    # aria2
    bc
    ffmpeg
    git
    wget

    ## Gaming
    # bubblewrap
    # dwarfs
    # fuse-overlayfs
    # wineWowPackages.staging
  ];

  programs = {
    anki = {
      enable = true;
      answerKeys = [
        {
          ease = 1;
          key = "x";
        }
        {
          ease = 3;
          key = "c";
        }
      ];
    };
    vesktop.enable = true;
    zathura.enable = true;
  };

  home.file.".scripts".source = ../../dump/.scripts;
  home.sessionPath = [
    "${config.home.homeDirectory}/.scripts"
    "${config.home.homeDirectory}/.scripts/aliases"
    "${config.home.homeDirectory}/.local/bin"
  ];
}
