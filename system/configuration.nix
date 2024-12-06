# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  # config,
  pkgs,
  ...
}:

{
  imports = [
    ./gnome.nix
    ./hardware-configuration.nix
    ./ld.nix
    ./nvidia.nix
    ./packages.nix
    ./system.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Environment
  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
      GSK_RENDERER = "ngl";
    };
    sessionVariables.NIXOS_OZONE_WL = "1"; # Make chromium run on wayland
    shells = with pkgs; [
      bash
      dash
      mksh
      fish
    ];
    binsh = "${pkgs.dash}/bin/dash";
    # https://wiki.nixos.org/wiki/GNOME#Excluding_GNOME_Applications
  };

  # Long live the better posix shell
  users.defaultUserShell = pkgs.mksh;

  # GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

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
  system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # gettin flakey
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
