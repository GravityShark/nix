{ lib, ... }:

{
  imports = [
    ./gnome.nix
    ./niri.nix
  ];

  options = {
    desktop = lib.mkOption {
      type = lib.types.enum [
        "niri"
        "gnome"
      ];
      description = "Type of desktop environment used: niri, gnome";
      example = "gnome";
    };
  };
}
