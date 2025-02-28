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
    emacs
    evince # Document viewer
    foliate # epub
    ghostty
    kdePackages.kdenlive
    krita
    libreoffice-fresh
    mcontrolcenter
    mpv
    obs-studio
    putty

    # Dev stuff
    clang
    gnumake
    go
    nodejs
    python3
    racket
    temurin-jre-bin

    # Systems
    bc
    dash
    doas-sudo-shim
    ffmpeg
    hunspell
    hunspellDicts.en_US
    unzip
    wineWowPackages.waylandFull

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
    pandoc
    pass
    ripgrep
    tmux
    neovim
    wl-clipboard
    yt-dlp
    ytfzf
    zoxide
  ];
}
