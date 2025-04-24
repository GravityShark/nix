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
    clang
    deluge
    # Dev stuff
    discord-canary
    emacs
    evince # Document viewer
    flatpak
    foliate # epub
    ghostty
    gnome-sound-recorder
    # gnumake
    # go
    # kdePackages.kdenlive
    krita
    libreoffice-fresh
    mcontrolcenter
    mpv
    # nodejs
    obs-studio
    # putty
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
    # zerotierone

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
    yt-dlp
    # ytfzf
    zoxide
  ];
}
