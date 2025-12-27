{ lib, ... }:

{
  imports = [
    ./desktop
    ./services
    ./system
    ./scripts.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-persistenced"
      "nvidia-settings"
      "nvidia-x11"
      "zerotierone"
    ];

  nix.settings.download-buffer-size = 500000000;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.extra-substituters = [ "https://nix-community.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
}
