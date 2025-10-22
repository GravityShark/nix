# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  # lib,
  inputs,
  ...
}:

{
  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate =
  #   pkg:
  #   builtins.elem (lib.getName pkg) [
  # "discord-canary"
  # "nvidia-x11"
  # "nvidia-settings"
  # "zerotierone"
  # "zoom"
  # "teams"
  # ];

  imports = [
    # Gnome + Wayland + NVIDIA will not working until this issue has been fixed https://gitlab.gnome.org/GNOME/mutter/-/issues/2969
    # "${
    #   builtins.fetchGit {
    #     url = "https://github.com/NixOS/nixos-hardware.git";
    #     rev = "7d9552ef6b02da7b8fafe426c0db5358ab8c4009";
    #   }
    # }/msi/gl65/10SDR-492"
    # ./nvidia.nix
    ./env.nix
    ./gnome.nix
    ./hardware-configuration.nix
    ./kanata.nix
    # ./lanzaboote.nix
    # ./ld.nix
    ./packages.nix
    ./services.nix
    ./system.nix
    # ./virt-manager.nix
  ];

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
  system.stateVersion = "25.05"; # Did you read the comment?

  # For somereason /dev/null is NOT being properly permissionisezed
  # system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # gettin flakey
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
