{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    desktop.labwc.enable = lib.mkEnableOption "enables labwc";
  };
  config = lib.mkIf config.desktop.labwc.enable {
    home.packages = with pkgs; [
      alacritty
      labwc-gtktheme
      labwc-menu-generator
      labwc-tweaks
      labwc-tweaks-gtk
      wl-clipboard
      wl-mirror
    ];

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.wlroots.default = [
        "wlr"
        "gtk"
      ];
    };

    wayland.windowManager.labwc = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
    };
  };
}
