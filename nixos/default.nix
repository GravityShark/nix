{ lib, ... }:

{
  imports = [
    ./desktop/default.nix
    ./services/default.nix
    ./system/default.nix
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
