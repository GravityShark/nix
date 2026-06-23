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
    assertions = [
      {
        assertion = config.desktop.noctalia.enable;
        message = "desktop.labwc.enable currently needs to have desktop.noctalia";
      }
    ];

    home.packages = with pkgs; [
      wlopm
      (writers.writeDashBin "screenshot" ''
        name=~/Pictures/Screenshots/Screenshot\ from\ $(date +'%Y-%m-%d %H-%M-%S').png
        ${slurp}/bin/slurp | ${grim}/bin/grim -g - - | ${coreutils}/bin/tee -a "$name" | ${wl-clipboard}/bin/wl-copy; ${notify-desktop}/bin/notify-desktop -a System -i "$name" "Screenshot copied to clipboard" "Stored in $name"
      '')
      (writers.writeDashBin "screenshot-full" ''
        name=~/Pictures/Screenshots/Screenshot\ from\ $(date +'%Y-%m-%d %H-%M-%S').png
        ${grim}/bin/grim - | ${coreutils}/bin/tee -a "$name" | ${wl-clipboard}/bin/wl-copy; ${notify-desktop}/bin/notify-desktop -a System -i "$name" "Screenshot copied to clipboard" "Stored in $name"
      '')
    ];

    xdg.configFile."labwc/rc.xml".source = ../../dump/.config/labwc/rc.xml;
    # config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix/dump/.config/labwc/rc.xml";

    wayland.windowManager.labwc = {
      enable = true;
      systemd.enable = true;
      xwayland.enable = true;
      autostart = lib.mkIf config.desktop.noctalia.enable [ "noctalia-shell" ];
      environment = [
        "CLUTTER_BACKEND=wayland"
        "ELECTRON_OZONE_PLATFORM_HINT=wayland"
        "GDK_BACKEND=wayland"
        "MOZ_ENABLE_WAYLAND=1"
        "NIXOS_OZONE_WL=1"
        "QT_QPA_PLATFORM=wayland;xcb"
        "SDL_VIDEODRIVER=wayland"
        # "WAYLAND_DISPLAY=wayland-0"
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
