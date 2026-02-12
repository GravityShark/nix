# man `home-configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{
  pkgs,
  ...
}:

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
    syncthing.enable = true;
    tmux.enable = true;
    zen-browser.enable = true;
  };

  service = {
    emacs.enable = false;
    keepassxc.enable = true;
    notes-backup.enable = true;
    swayidle.enable = true;
  };

  home.stateVersion = "25.11"; # Read Home Manager release notes when changing.

  ################################## Extra ###################################

  ## Packages
  home.packages = with pkgs; [
    ## Apps
    baobab
    caprine
    chromium
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
    kdePackages.kdenlive # Video editor (I should enable gpu when using this)
    krita # Drawing

    # foot
    # fuzzel
    gnome-system-monitor
    # grim
    # htop
    # mako
    nautilus
    pwvucontrol
    swayimg
    wdisplays
    # wev

    ## Work
    onlyoffice-desktopeditors
    pdfarranger
    # teams-for-linux
    # telegram-desktop
    # zoom-us

    ## CLIs
    # aria2
    p7zip-rar
    wget

    ## Gaming
    # (bottles-unwrapped.override { removeWarningPopup = true; })
    # dolphin-emu
    # gamescope
    # rare
    # umu-launcher
    # vkbasalt
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
