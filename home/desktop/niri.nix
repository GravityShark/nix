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
    xdg.configFile = {
      "niri/config.kdl".source = ../../dump/.config/niri/config.kdl;
    };

    home.packages = with pkgs; [
      brightnessctl
      foot
      # fuzzel
      gnome-system-monitor
      # grim
      # htop
      # mako
      nautilus
      nirius
      notify-desktop
      powertop
      pwvucontrol
      swayimg
      wdisplays
      wev
      xlsclients
    ];
  };
}
