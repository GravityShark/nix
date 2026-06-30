# man `home-configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{ pkgs, ... }:

{
  mime.enable = true;
  scripts.enable = true;

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
    fastfetch.enable = true;
    fish.enable = true;
    fonts.enable = true;
    fzf.enable = true;
    ghostty.enable = true;
    minecraft.enable = true;
    neovim.enable = true;
    obs.enable = true;
    ocr.enable = true;
    syncthing.enable = true;
    tmux.enable = true;
    zen-browser.enable = true;
  };

  service = {
    emacs.enable = false;
    keepassxc.enable = true;
    notes-backup.enable = true;
    swayidle.enable = false;
  };

  home.stateVersion = "25.11"; # Read Home Manager release notes when changing.

  ################################## Extra ###################################

  xdg.configFile."MangoHud/MangoHud.conf".source = ../../dump/.config/MangoHud/MangoHud.conf;
  ## Other programss
  programs = {
    mangohud.enable = true;
    mpv.enable = true;
    vesktop.enable = true;
    zathura = {
      enable = true;
      options.selection-clipboard = "clipboard";
    };
  };

  ## Packages
  home.packages = with pkgs; [
    ## Apps
    baobab
    # chromium
    # easyeffects
    gnome-system-monitor
    pear-desktop
    # racket
    # selectdefaultapplication
    super-productivity

    ## Media
    audacity
    # gnome-sound-recorder
    kdePackages.kdenlive # Video editor (I should enable gpu when using this)
    krita # Drawing

    ## Specific file type
    nautilus
    qbittorrent
    swayimg

    ## Work
    # caprine
    onlyoffice-desktopeditors
    # pdfarranger
    # teams-for-linux
    # telegram-desktop
    # zoom-us

    ## CLIs
    _7zz-rar
    # aria2
    # aria2p
    # ntfs3g
    # wget
    yt-dlp
    ytfzf

    ## Gaming
    # (bottles.override { removeWarningPopup = true; })
    # dolphin-emu
    # gamescope
    # rare
    # umu-launcher
    # vkbasalt
    # wineWow64Packages.stable
    # wineWow64Packages.staging
    # wineWow64Packages.stagingFull
    # wineWow64Packages.waylandFull
    faugus-launcher
  ];
}
