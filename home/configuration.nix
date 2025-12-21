{ lib, ... }:

{
  # ENABLE IF NOT NIXOS
  # targets.genericLinux.enable = false;
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  imports = [
    # ./gnome.nix
    ./noctalia.nix

    # ./anyrun.nix
    # ./emacs.nix
    ./gaming.nix
    ./ghostty.nix
    ./keepassxc.nix
    ./mcsr.nix
    ./stylix.nix
    ./niri.nix
    # ./vicinae.nix
    # ./walker.nix

    ./restic.nix
    ./syncthing.nix

    # ./desktop.nix
    ./home.nix
    # ./mime.nix
    ./packages.nix
  ];

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "lunarclient"
    ];
}
