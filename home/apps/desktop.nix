{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.desktop.enable = lib.mkEnableOption "enables desktop apps like pwvucontrol, swayimg and more. apps required for regular desktop use";
  };

  config = lib.mkIf config.apps.desktop.enable {
    home.packages = with pkgs; [
      # foot
      # fuzzel
      gnome-system-monitor
      # grim
      # htop
      # mako
      nautilus
      pwvucontrol
      swayimg
      wdisplays
      # wev
    ];
  };
}
