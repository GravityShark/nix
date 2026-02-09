{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    desktop.mango.enable = lib.mkEnableOption "enables mango";
  };
  config = lib.mkIf config.desktop.mango.enable {

    assertions = [
      {
        assertion = config.desktop.noctalia.enable;
        message = "desktop.niri currently needs to have desktop.noctalia";
      }
    ];

    # xdg.configFile = {
    #   "niri/config.kdl".source = ../../dump/.config/niri/config.kdl;
    # };
    #
    home.packages = with pkgs; [
      foot
      brightnessctl
      # notify-desktop
      wl-clipboard
      wl-mirror
      # xlsclients
    ];
  };
}
