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
    clang
    # deluge # Torrenting
    discord-canary
    emacs
    evince # Document viewer
    foliate # Epub viewer
    ghostty # Terminal
    gnome-sound-recorder
    # kdePackages.kdenlive
    krita
    libreoffice-fresh
    mcontrolcenter # MSI
    mpv

    # Dev stuff
    gnumake
    go
    nodejs
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
    yt-dlp
    # ytfzf
    zoxide
  ];
}
