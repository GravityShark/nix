{ pkgs, unstable, ... }:

{
  environment.packages = with pkgs; [
    # Apps
    anki
    emacs-gtk
    evince # Document viewer
    foot
    krita
    # libreoffice-fresh
    mpv
    obs-studio
    unstable.mcontrolcenter

    # Dev stuff
    clang
    gnumake
    go
    nodejs
    python3
    racket
    temurin-jre-bin

    # Systems
    dash
    doas-sudo-shim
    hunspell
    hunspellDicts.en_US
    unstable.home-manager
    unstable.wineWowPackages.waylandFull
    unzip

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
    pass
    ripgrep
    tmux
    unstable.neovim
    wl-clipboard
    yt-dlp
    ytfzf
    zoxide
  ];
}
