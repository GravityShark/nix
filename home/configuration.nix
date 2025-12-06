{ ... }:

{
  # ENABLE IF NOT NIXOS
  # targets.genericLinux.enable = false;
  # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  imports = [
    # ./gnome.nix
    # ./mangowc.nix

    ./desktop.nix
    # ./emacs.nix
    ./home.nix
    ./keepassxc.nix
    # ./mime.nix
    ./packages.nix
    ./restic.nix
    ./syncthing.nix
  ];

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
