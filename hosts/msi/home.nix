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
      # theme = "rose-pine";
      theme = "gruvbox-material-light";
    };
  };

  service = {
    notes-backup.enable = true;
    keepassxc.enable = true;
    swayidle.enable = true;
  };

  ####### Extra shit
  home.file.".scripts".source = ../../dump/.scripts;

  home.sessionPath = [
    "${config.home.homeDirectory}/.scripts"
    "${config.home.homeDirectory}/.scripts/aliases"
  ];

  xdg.configFile = {
    "fastfetch".source = ../../dump/.config/fastfetch;
  };

  home.packages = with pkgs; [
    caprine
    # (caprine.overrideAttrs (old: rec {
    #   pname = "caprine-ng";
    #   version = "2.60.3";
    #   src = fetchFromGitHub {
    #     owner = "Alex313031";
    #     repo = "caprine-ng";
    #     rev = "v${version}";
    #     hash = "sha256-DCjjNdSxpFp4vRXSPdSN0aiHG4SISEZ6IuBeHqz+b2g=";
    #   };
    #   # How to set npm hash https://discourse.nixos.org/t/npmdepshash-override-what-am-i-missing-please/50967/3
    #   npmDepsHash = "sha256-OX+hqXSa+HAbAdOEtoOw56ogfVqGm1aWQajmO0+3snI=";
    #   npmDeps = fetchNpmDeps {
    #     inherit src;
    #     name = "${pname}-${version}-npm-deps";
    #     hash = npmDepsHash;
    #   };
    # }))
    easyeffects
    # obsidian
    # qbittorrent
    # selectdefaultapplication
    super-productivity
    vial
    vlc # Videos + Music
    youtube-music

    ## Media
    # audacity
    # gnome-sound-recorder
    kdePackages.kdenlive # Video editor (I should enable gpu when using this)
    krita # Drawing

    ## School
    onlyoffice-desktopeditors
    pdfarranger
    # teams-for-linux
    # telegram-desktop
    # zoom-us

    ## CLIs
    # bc
    # ffmpeg
    # doas-sudo-shim
    # efibootmgr
    fastfetch
    git
    wget

    ## Gaming
    # bubblewrap
    # dwarfs
    # fuse-overlayfs
    # gamemode
    # wineWowPackages.staging
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
    # vesktop.enable = true;
    zathura.enable = true;
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
