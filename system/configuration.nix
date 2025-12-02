# man `configuration.nix(5)` or `nixos-help`

{ lib, ... }:

{
  imports = [
    # Gnome + Wayland + NVIDIA will not work until this issue has been fixed https://gitlab.gnome.org/GNOME/mutter/-/issues/2969
    # "${
    #   builtins.fetchGit {
    #     url = "https://github.com/NixOS/nixos-hardware.git";
    #     rev = "7d9552ef6b02da7b8fafe426c0db5358ab8c4009";
    #   }
    # }/msi/gl65/10SDR-492"
    # ./gnome.nix
    ./hardware-configuration.nix
    ./kanata.nix
    # ./lanzaboote.nix
    ./msi.nix
    # ./nvidia.nix
    ./packages.nix
    ./services.nix
    ./system.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      # "discord-canary"
      "nvidia-settings"
      "nvidia-x11"
      "obsidian"
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

  # For somereason /dev/null is NOT being properly permissionisezed
  # system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # systemd.services."chmod" = {
  #   script = ''
  #     chmod 777 /dev/null
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };

  nix.settings.download-buffer-size = 500000000;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
