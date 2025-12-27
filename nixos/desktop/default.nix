{ lib, ... }:

{
  imports = [
    ./gnome.nix
    ./niri.nix
  ];

  options.displayserver = lib.mkOption {
    type = lib.types.enum [
      "niri"
      "gnome"
    ];
    description = "Type of display server used: niri, gnome";
    example = "gnome";
  };
}
