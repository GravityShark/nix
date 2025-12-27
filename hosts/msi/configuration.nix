# man `configuration.nix(5)` or `nixos-help`

{ lib, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  intel.enable = true;
  msi.enable = true;
  nvidia.enable = true;

  openrazer.enable = true;

  scripts.enable = true;
  kanata.enable = true;
  networking.enable = true;
  pipewire.enable = true;
  printing.enable = true;
  vial.enable = true;
  ydotool.enable = true;
  zerotierone.enable = true;

  niri.enable = true;

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix.settings.download-buffer-size = 500000000;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.extra-substituters = [ "https://nix-community.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  # For somereason /dev/null is NOT being properly permissionisezed
  # system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # systemd.services."chmod" = {
  #   script = ''
  #     chmod 777 /dev/null
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };
}
