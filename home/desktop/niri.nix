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

    xdg.configFile = {
      "niri/config.kdl".source = ../../dump/.config/niri/config.kdl;
    };

    home.packages = with pkgs; [
      brightnessctl
      nirius
      # notify-desktop
      wl-clipboard
      # xlsclients
    ];
  };
}
