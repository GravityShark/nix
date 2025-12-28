{ ... }:

# You should NEVER edit this file at all because it's already perfect
# But it contains settings that edit the entire system as a whole in some way
{
  imports = [
    ./intel.nix
    # ./lanzaboote.nix
    ./msi.nix
    ./nvidia.nix
    ./openrazer.nix
    ./doas.nix
    ./vial.nix
  ];

}
