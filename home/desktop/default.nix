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
        assertion = !(config.desktop.desktop.noctalia.enable || config.desktop.stylix.enable);
        message = "desktop.gnome is currently incompatible with desktop.noctalia or desktop.stylix";
      }
    ];
  };
}
