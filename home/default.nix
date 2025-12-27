{ ... }:

{
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

    ./restic.nix
    ./syncthing.nix

    # ./desktop.nix
    ./links.nix
    ./mime.nix
    ./packages.nix
  ];

  programs.home-manager.enable = true;
}
