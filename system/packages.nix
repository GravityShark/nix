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
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    emacs
    evince # Document viewer
    # foot
    ghostty
    krita
    libreoffice-fresh
    mpv
    obs-studio
    kdePackages.kdenlive
    mcontrolcenter

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
