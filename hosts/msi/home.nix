{ pkgs, ... }:

{
  links.enable = true;
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

  xdg.configFile = {
    "fastfetch".source = ../../dump/.config/fastfetch;
    # "xdg-terminals.list".source = ../dump/.config/xdg-terminals.list;
  };

  home.packages = with pkgs; [
    selectdefaultapplication
    equibop
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
    doas-sudo-shim
    # efibootmgr
    fastfetch
    fd
    ffmpeg
    ghostscript_headless
    git
    imagemagick
    powertop
    ripgrep
    unzip

    # appimage-run
    # tomato-c # find something better
    # xdg-terminal-exec

    # obs-studio
    # prismlauncher
    # temurin-jre-bin
    # waywall
    #
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
    obsidian = {
      enable = true;
      # vaults.Notes = {
      #   enable = true;
      #   target = "Notes";
      # };
    };
    zathura.enable = true;
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
