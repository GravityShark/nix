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

  environment = {
    systemPackages = [
      # New packages
      pkgs.doas-sudo-shim
      pkgs.efibootmgr
      pkgs.evince
      pkgs.foot
      pkgs.obs-studio
      pkgs.racket
      pkgs.temurin-jre-bin
      pkgs-unstable.home-manager
      pkgs-unstable.mcontrolcenter
      pkgs.wl-clipboard

      # Mason
      pkgs.clang-tools
      pkgs.emmet-language-server
      pkgs.gofumpt
      pkgs.goimports-reviser
      pkgs.golangci-lint
      pkgs.golines
      pkgs.gopls
      pkgs.lua-language-server
      pkgs.prettierd
      pkgs.pyright
      pkgs.quick-lint-js
      pkgs.ruff
      pkgs.shfmt
      pkgs.stylua
      pkgs.tailwindcss-language-server
      pkgs.typescript-language-server
      pkgs.vscode-langservers-extracted # contains html-lsp and json-lsp
      # Neovim dependencies
      pkgs.clang
      pkgs.gnumake
      pkgs.go
      pkgs.nodejs
      pkgs.python3
      pkgs.unzip

      # Packages from the past
      pkgs.anki
      pkgs.dash
      pkgs.emacs-gtk
      pkgs.eza
      pkgs.fastfetch
      pkgs.fd
      pkgs.fish
      pkgs.fzf
      pkgs.git
      pkgs.hunspell
      pkgs.hunspellDicts.en_US
      # pkgs.hunspellDicts.tl
      pkgs.joshuto
      pkgs.krita
      # pkgs.libreoffice-fresh
      pkgs.mksh
      pkgs.mpv
      pkgs.pass
      pkgs.ripgrep
      pkgs.tmux
      pkgs-unstable.neovim
      pkgs-unstable.wineWowPackages.waylandFull
      pkgs.yt-dlp
      pkgs.ytfzf
      pkgs.zoxide
    ];
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
      GSK_RENDERER = "ngl";
    };
    sessionVariables.NIXOS_OZONE_WL = "1";
    shells = with pkgs; [
      bash
      dash
      mksh
      fish
    ];
    binsh = "${pkgs.dash}/bin/dash";
    # https://wiki.nixos.org/wiki/GNOME#Excluding_GNOME_Applications
    gnome.excludePackages = with pkgs; [
      epiphany
      geary
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-software
      gnome-logs
      gnome-music
      gnome-text-editor
      gnome-tour # GNOME Shell detects the .desktop file on first log-in.
      gnome-weather
      # seahorse # Passwords and Keys
      # simple-scan
      # snapshot
      # sysprof
      totem # Videos
    ];
  };

  # Long live the better posix shell
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

  # GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
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
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # allow it to work with windows time tbh
  time.hardwareClockInLocalTime = true;

  # use zen kernel kuh
  boot.kernelPackages = pkgs.linuxPackages_zen;

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

  # Optimise package sizes
  nix.optimise.automatic = true;
  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # For somereason /dev/null is NOT being properly permissionisezed
  system.activationScripts.chmod-dev-null.text = ''
    chmod 777 /dev/null
  '';

  # gettin flakey
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
