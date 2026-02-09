{ lib, ... }:

{
  imports = [
    ./gnome.nix
    ./niri.nix
  ];

  options.desktop.display-server = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "mango"
        "niri"
        "gnome"
      ]
    );
    description = "Type of display server used: niri, gnome";
    example = "gnome";
    default = null;
  };
}
