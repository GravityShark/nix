{ ... }:

{
  imports = [
    ./doas.nix
    ./drag-click.nix
    ./intel.nix
    # ./lanzaboote.nix
    ./logind.nix
    ./msi.nix
    ./nvidia.nix
    ./systemd-boot.nix
    ./thp.nix
    ./zram.nix
  ];
}
