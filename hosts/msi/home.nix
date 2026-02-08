{
  config,
  pkgs,
  osConfig,
  ...
}:

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
    baobab
    caprine
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

    ## Work
    onlyoffice-desktopeditors
    pdfarranger
    # teams-for-linux
    # telegram-desktop
    # zoom-us

    ## CLIs
    # aria2
    ffmpeg
    git
    p7zip-rar
    wget

    ## Gaming
    # dolphin-emu
    # rare
    bottles-unwrapped
  ];

  ## Other programss
  programs = {
    lutris = {
      enable = true;
      winePackages = with pkgs; [ wineWow64Packages.waylandFull ];
      protonPackages = [ pkgs.proton-ge-bin ];
      steamPackage = osConfig.programs.steam.package;
      extraPackages = with pkgs; [ gamescope ];
    };
    vesktop.enable = true;
    zathura = {
      enable = true;
      options.selection-clipboard = "clipboard";
    };
  };
}
