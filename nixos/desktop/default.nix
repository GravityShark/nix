{ lib, ... }:

{
  imports = [
    ./gnome.nix
    ./mango.nix
    ./niri.nix
  ];

  options.desktop.display-server = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "gnome"
        "mango"
        "niri"
      ]
    );
    description = "Type of display server used: gnome, mango, niri";
    example = "gnome";
    default = null;
  };
}
