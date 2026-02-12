{ lib, config, ... }:

{
  imports = [
    ./gnome.nix
    # ./mango.nix
    ./niri.nix
    ./greetd.nix
    ./autostart.nix
  ];

  options.desktop.display-server = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "gnome"
        "niri"
      ]
    );
    description = "Type of display server used: gnome, niri";
    example = "gnome";
    default = null;
  };

  options.desktop.login-manager = lib.mkOption {
    type = lib.types.nullOr (
      lib.types.enum [
        "autostart"
        "greetd"
      ]
    );
    description = "Type of login manager used: autostart, greetd";
    example = "autostart";
    default = null;
  };

  options.desktop.command = lib.mkOption {
    type = lib.types.str;
    description = "You should not use this, but this is what is ran by
                  login-managers. Should only be set by the display server config";
    example = "sway";
    default = null;
  };

  config = lib.mkIf (config.desktop.login-manager != null) {
    assertions = [
      {
        assertion = (config.desktop.command != null);
        message = "please define a desktop.command if you want to use desktop.login-manager";
      }
    ];
  };
}
