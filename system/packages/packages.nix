{ pkgs, ... }:

# List packages installed in system profile. To search, run:
# $ nix search nixpkgs wget
{
  imports = [
    ./openrazer.nix
    ./update-scripts.nix
  ];
  environment.systemPackages = with pkgs; [
    home-manager

    mcontrolcenter # MSI
    qbittorrent

    ## File viewer
    vlc # Videos + Music
    # zathura # Documents

    ## Media
    # audacity
    # gnome-sound-recorder
    # kdePackages.kdenlive # Video editor (I should enable gpu when using this)
    krita # Drawing

    ## School
    onlyoffice-desktopeditors
    pdfarranger
    # telegram-desktop
    # zoom-us

    ## CLIs
    # bc
    # dash
    efibootmgr
    eza
    fastfetch
    fd
    ffmpeg
    # fish
    # fzf
    ghostscript_headless
    git
    imagemagick
    # neovim
    restic
    ripgrep
    tmux
    unzip
    zoxide

    ## Dev
    clang
    gnumake
    go
    # nodejs
    python3
  ];
}
