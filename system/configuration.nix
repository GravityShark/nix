# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  # config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./gnome.nix
    ./hardware-configuration.nix
    ./ld.nix
    ./nvidia.nix
    ./packages.nix
    ./system.nix
    ./services.nix
    ./lanzaboote.nix
    # ./virt-manager.nix
  ];

  # Environment
  environment = {
    variables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
      GSK_RENDERER = "ngl";
    };
    # currengly making chromium run on wayland makes it load much slower
    # sessionVariables.NIXOS_OZONE_WL = "1"; # Make chromium run on wayland
    # sessionVariables.QT_QPA_PLATFORM = "wayland";
    shells = with pkgs; [
      bash
      dash
      mksh
      fish
    ];
    binsh = "${pkgs.dash}/bin/dash";
  };
  # Long live the better posix shell
  users.defaultUserShell = pkgs.mksh;

  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };

  # Optimise package sizes
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "01:30" ];
  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "01:00";
    options = "--delete-older-than 5d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # For somereason /dev/null is NOT being properly permissionisezed
  # system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # gettin flakey
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
