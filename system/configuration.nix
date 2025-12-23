# man `configuration.nix(5)` or `nixos-help`

{ lib, ... }:

{
  imports = [
    ## Desktop Environments (Mutually exclusive)
    # ./gnome.nix
    ./niri.nix

    ## Services
    ./bluetooth.nix
    ./kanata.nix
    ./networking.nix
    ./pipewire.nix
    # ./printing.nix
    # ./vial.nix
    ./ydotool.nix

    ## Global
    ./intel.nix
    # ./lanzaboote.nix
    ./msi.nix
    ./nvidia.nix

    ## Meta
    ./hardware-configuration.nix # Copy exactly from /etc/nixos
    ./packages.nix
    ./services.nix
    ./system.nix # You NEVER have to change this file ever again
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # "discord-canary"
      "nvidia-persistenced"
      "nvidia-settings"
      "nvidia-x11"
      # "teams"
      # "zerotierone"
      # "zoom"
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # nix.settings.download-buffer-size = 500000000;
  # nix.settings.experimental-features = [
  #   "nix-command"
  #   "flakes"
  # ];

  # For somereason /dev/null is NOT being properly permissionisezed
  # system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # systemd.services."chmod" = {
  #   script = ''
  #     chmod 777 /dev/null
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };
}
