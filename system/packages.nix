{
  pkgs,
  ...
}:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Apps
    anki
    # audacity
    discord-canary
    emacs
    evince # Document viewer
    flatpak
    foliate # epub
    ghostty
    gnome-sound-recorder
    # kdePackages.kdenlive
    krita
    libreoffice-fresh
    mcontrolcenter
    mpv
    obs-studio
    # putty

    # Dev stuff
    # clang
    # gnumake
    # go
    # nodejs
    # python3
    racket
    # temurin-jre-bin

    # Systems
    bc
    dash
    doas-sudo-shim
    ffmpeg
    hunspell
    hunspellDicts.en_US
    unzip
    # winetricks
    # wineWowPackages.stable

    # CLIs
    efibootmgr
    eza
    fastfetch
    fd
    fish
    fzf
    git
    joshuto
    mksh
    # pandoc
    pass
    ripgrep
    tmux
    neovim
    wl-clipboard
    # yt-dlp
    # ytfzf
    zoxide
  ];
}
