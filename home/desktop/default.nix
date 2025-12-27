{ lib, config, ... }:

{
  imports = [
    ./gnome.nix
    ./noctalia.nix
    ./stylix.nix
  ];

  config = lib.mkIf config.gnome.enable {
    assertions = [
      {
        assertion = !(config.noctalia.enable || config.stylix.enable);
        message = "desktop.gnome is currently incompatible with desktop.noctalia or desktop.stylix";
      }
    ];
  };
}
