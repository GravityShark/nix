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
    kdePackages.kdenlive
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
    ffmpeg
    bc
    dash
    doas-sudo-shim
    hunspell
    hunspellDicts.en_US
    unstable.home-manager
    unstable.wineWowPackages.waylandFull
    unzip

    # CLIs
    pandoc
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
