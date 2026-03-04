{
  config,
  lib,
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

    xdg.configFile."niri/config.kdl".source = ../../dump/.config/niri/config.kdl;
    xdg.configFile."niri/config.kdl".text = lib.mkIf config.desktop.noctalia.enable ''
      spawn-at-startup "noctalia-shell"
    '';

    services.polkit-gnome.enable = true;
    services.wl-clip-persist.enable = true;
  };
}
