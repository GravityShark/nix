{
  pkgs,
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

    home.packages = with pkgs; [
      brightnessctl
      nirius
      wl-clipboard
      wl-mirror
    ];

    # services.wl-clip-persist.enable = true;
    services.polkit-gnome.enable = true;
  };
}
