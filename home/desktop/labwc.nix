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

    xdg.configFile."labwc/rc.xml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/dump/.config/labwc/rc.xml"

    wayland.windowManager.labwc = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      environment = [
        "QT_QPA_PLATFORM=wayland;xcb"
        "GDK_BACKEND=wayland"
        "SDL_VIDEODRIVER=wayland"
        "CLUTTER_BACKEND=wayland"
        "ELECTRON_OZONE_PLATFORM_HINT=wayland"
        "NIXOS_OZONE_WL=1"
        "MOZ_ENABLE_WAYLAND=1"
      ];
      menu = [
        {
          label = "pipemenu";
          menuId = "menu";
          execute = "/home/user/nix/scripts/pipe.sh";
        }
        {
          menuId = "client-menu";
          label = "Client Menu";
          icon = "";
          items = [
            {
              label = "Maximize";
              icon = "";
              action = {
                name = "ToggleMaximize";
              };
            }
            {
              label = "Fullscreen";
              action = {
                name = "ToggleFullscreen";
              };
            }
            {
              label = "Terminal";
              action = {
                name = "Execute";
                command = "xdg-terminal-exec";
              };
            }
            {
              label = "Move Left";
              action = {
                name = "SendToDesktop";
                to = "left";
              };
            }
            {
              separator = { };
            }
            {
              label = "Workspace";
              menuId = "workspace";
              icon = "";
              items = [
                {
                  label = "Move Left";
                  action = {
                    name = "SendToDesktop";
                    to = "left";
                  };
                }
              ];
            }
            {
              separator = { };
            }
          ];
        }
      ];

    };
  };
}
