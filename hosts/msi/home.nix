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
    anki.enable = true;
    desktop.enable = true;
    fastfetch.enable = true;
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
    pear-desktop
    # qbittorrent
    # selectdefaultapplication
    super-productivity
    # vial
    vlc # Videos + Music

    ## Media
    # audacity
    gnome-sound-recorder
    # kdePackages.kdenlive # Video editor (I should enable gpu when using this) ## uhh this is not in cache yet and it broke
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
    p7zip-rar
    wget

    ## Gaming
    bottles
    dolphin-emu
    flatpak # roblox
    rare

    bubblewrap
    dwarfs
    fuse-overlayfs
  ];

  ## Other programss
  programs = {
    vesktop.enable = true;
    zathura = {
      enable = true;
      options.selection-clipboard = "clipboard";
    };
  };
}
