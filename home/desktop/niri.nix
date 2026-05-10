{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    desktop.niri.enable = lib.mkEnableOption "enables niri";
  };

  config = lib.mkIf config.desktop.niri.enable {
    assertions = [
      {
        assertion = config.desktop.noctalia.enable;
        message = "desktop.niri currently needs to have desktop.noctalia";
      }
    ];

    home.packages = [ pkgs.nirius ];

    xdg.configFile."niri/config.kdl".text =
      builtins.readFile ../../dump/.config/niri/config.kdl
      + (
        if config.desktop.noctalia.enable then
          ''
            spawn-at-startup "noctalia-shell"
            spawn-at-startup "noctalia-performance"
          ''
        else
          ""
      );

    services.polkit-gnome.enable = true;
    services.wl-clip-persist.enable = true;
  };
}
