{ lib, config, ... }:

{
  imports = [
    ./gnome.nix
    ./noctalia.nix
    ./stylix.nix
  ];

  config = lib.mkIf config.desktop.gnome.enable {
    assertions = [
      {
        assertion = !(config.desktop.desktop.noctalia.enable);
        message = "desktop.gnome is currently incompatible with desktop.noctalia";
      }
      {
        assertion = !(config.desktop.stylix.enable);
        message = "desktop.gnome is currently incompatible with desktop.stylix";
      }
      {
        assertion = !(config.service.swayidle.enable);
        message = "desktop.gnome is currently incompatible with service.swayidle";
      }
    ];
  };
}
