{
  pkgs,
  ...
}:

{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # home-manager

    # Apps

    anki
    # deluge # Torrenting
    # discord-canary
    emacs
    evince # Document viewer
    foliate # Epub viewer
    ghostty # Terminal
    gnome-sound-recorder
    # kdePackages.kdenlive
    keepassxc
    krita
    libreoffice-fresh
    mcontrolcenter # MSI
    mpv
    telegram-desktop
    zoom-us

    # Dev stuff

    clang
    gnumake
    go
    nodejs
    python3
    racket

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
    neovim
    # pandoc
    pass
    restic
    ripgrep
    tmux
    wl-clipboard
    yt-dlp
    # ytfzf
    zoxide
  ];
}
