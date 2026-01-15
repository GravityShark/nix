{ config, pkgs, ... }:

{
  mime.enable = true;

  desktop = {
    niri.enable = true;
    noctalia.enable = true;
    stylix = {
      enable = true;
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

  ## Local scripts that I would prefer to not add to my shell directly
  home.file.".scripts".source = ../../dump/.scripts;
  home.sessionPath = [
    "${config.home.homeDirectory}/.scripts"
    "${config.home.homeDirectory}/.scripts/aliases"
    "${config.home.homeDirectory}/.local/bin"
  ];

  ## Packages
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
    bubblewrap
    dwarfs
    fuse-overlayfs
    wineWowPackages.staging
  ];

  ## Other programss
  programs = {
    anki = {
      enable = true;
      # reduceMotion = true;
      # sync = {
      #   autoSync = true;
      #   syncMedia = true;
      # };
      # spacebarRatesCard = false;
      # addons = with pkgs; [
      #   ankiAddons.review-heatmap
      #
      #   (anki-utils.buildAnkiAddon (finalAttrs: {
      #     pname = "ankitty";
      #     version = "1.1.1";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "marvinruder";
      #       repo = "ankitty";
      #       rev = "v${finalAttrs.version}";
      #       sparseCheckout = [ "src/ankitty" ];
      #       hash = "sha256-ra7kv+4Fh3YvXW5+vylvhvTF+E0kn0Futy1TJ5ygrJw=";
      #     };
      #     sourceRoot = "${finalAttrs.src.name}/src/ankitty";
      #   }))
      #
      #   (anki-utils.buildAnkiAddon (finalAttrs: {
      #     pname = "anki-note-linker";
      #     version = "0-unstable-2025-9-20";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "gugutu";
      #       repo = "Anki-Note-Linker";
      #       rev = "cfd51d17cfd3b40d21a7670d8c79728c8e8e4488";
      #       hash = "sha256-sB7SoblB8lXxiSftTAK101CdeEmqImpr862BIN/5SAY=";
      #     };
      #   }))
      #
      #   (anki-utils.buildAnkiAddon (finalAttrs: {
      #     pname = "automatic-note-linker";
      #     version = "0-unstable-2024-9-16";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "rrzhang139";
      #       repo = "automatic_note_linker";
      #       rev = "114ae3593e338a95d6524aa5e3163746b36fbe56";
      #       hash = "sha256-Xy5kZPOqVnLoPK/YzFGNE5iLBJbZ06b1nMUdtkhr27M=";
      #     };
      #   }))
      # ];
      # answerKeys = [
      #   {
      #     ease = 1;
      #     key = "x";
      #   }
      #   {
      #     ease = 3;
      #     key = "c";
      #   }
      # ];
    };
    vesktop.enable = true;
    zathura = {
      enable = true;
      options.selection-clipboard = "clipboard";
    };
  };
}
