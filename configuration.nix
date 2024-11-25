# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix
    ./defaults.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages
  # GnuPG
  programs = {
    steam.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
  };
  # services.pcscd.enable = true;
  environment.systemPackages = [
    # New packages
    pkgs.foot
    pkgs.home-manager
    pkgs.racket
    pkgs.wl-clipboard

    # Neovim dependencies
    pkgs.clang
    pkgs.gnumake
    pkgs.go
    pkgs.nodejs
    pkgs.python3
    pkgs.unzip

    # Packages from the past
    pkgs.dash
    pkgs.deluge
    pkgs.emacs-gtk
    pkgs.eza
    pkgs.fastfetch
    pkgs.fd
    pkgs.fish
    pkgs.fzf
    pkgs.gamemode
    pkgs.git
    pkgs.gnupg
    pkgs.htop
    pkgs.hunspell
    pkgs.joshuto
    pkgs.krita
    pkgs.languagetool
    pkgs.libreoffice-fresh
    pkgs.mksh
    pkgs.pass
    pkgs.poppler
    # pkgs.qbittorrent
    pkgs.ripgrep
    pkgs.screenkey
    pkgs.tmux
    pkgs-unstable.neovim
    pkgs.wineWowPackages.staging
    pkgs.yt-dlp
    pkgs.ytfzf
    pkgs.zoxide
  ];
  environment.variables = {
    EDITOR = "nvim";
  };
  environment.shells = with pkgs; [
    bash
    dash
    mksh
    fish
  ];
  users.defaultUserShell = pkgs.mksh;

  # Use doas instead of sudo
  # https://www.reddit.com/r/NixOS/comments/rts8gm/sudo_or_doas/
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "gravity" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  # Vial udev rule
  services.udev.extraRules = ''
    "KERNEL=="hidraw*", 
    SUBSYSTEM=="hidraw", 
    ATTRS{serial}=="*vial:f64c2b3c*", 
    MODE="0660", 
    GROUP="100", 
    TAG+="uaccess", 
    TAG+="udev-acl"'';

  services.flatpak.enable = true;

  # allow it to work with windows time tbh
  time.hardwareClockInLocalTime = true;

  # enable support for ntfs
  boot.supportedFilesystems = [ "ntfs" ];

  # Hosts file
  networking = {
    hosts = {
      "192.168.0.3" = [ "clr" ];
    };
    stevenblack = {
      enable = true;
      block = [
        "gambling"
        "porn"
      ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # gettin flakey
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
