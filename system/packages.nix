{ pkgs, unstable, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Apps
    anki
    emacs-gtk
    evince # Document viewer
    foot
    krita
    unstable.kdePackages.kdenlive
    libreoffice-fresh
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
    bc
    dash
    doas-sudo-shim
    ffmpeg
    hunspell
    hunspellDicts.en_US
    # unstable.home-manager
    # unstable.wineWowPackages.waylandFull
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
    pandoc
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
