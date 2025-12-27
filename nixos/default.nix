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
}
