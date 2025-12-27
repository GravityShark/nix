{ lib, ... }:

{
  # ENABLE IF NOT NIXOS
  # targets.genericLinux.enable = false;
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  imports = [
    # ./gnome.nix
    ./noctalia.nix

    ./gaming.nix
    ./ghostty.nix
    ./keepassxc.nix
    ./mcsr.nix
    ./neovim.nix
    ./nixcraft.nix
    ./stylix.nix
    # ./wayland-pipewire-idle-inhibit.nix

    ./restic.nix
    ./syncthing.nix

    # ./desktop.nix
    ./home.nix
    ./mime.nix
    ./packages.nix
  ];

}
