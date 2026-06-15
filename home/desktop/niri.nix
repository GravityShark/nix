{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.niri.homeModules.config
    inputs.niri.homeModules.stylix
  ];
  options = {
    desktop.niri.enable = lib.mkEnableOption "enables niri";
  };

  config = lib.mkIf config.desktop.niri.enable {
    home.packages = [ pkgs.nirius ];
    services.polkit-gnome.enable = true;
    services.wl-clip-persist.enable = true;

    stylix.targets.niri.enable = config.desktop.stylix.enable;

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;
    # https://niri-wm.github.io/niri/Configuration
    # https://github.com/sodiboo/niri-flake/blob/main/docs.md
    programs.niri.settings = {
      input = {
        keyboard = {
          repeat-rate = 0;
        };
        touchpad = {
          click-method = "clickfinger";
          natural-scroll = true;
          accel-speed = 0.67;
          accel-profile = "flat";
          scroll-method = "two-finger";
        };
        mouse = {
          natural-scroll = true;
          accel-speed = -0.73;
          accel-profile = "flat";
          scroll-method = "on-button-down";
        };
        focus-follows-mouse.max-scroll-amount = "0%";
      };

      outputs = {
        "eDP-1" = {
          enable = true;
          # background-color = "#000000";
        };
      };

      cursor = {
        hide-when-typing = true;
        hide-after-inactive-ms = 1000;
      };

      environment = {
        QT_QPA_PLATFORM = "wayland;xcb";
        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
      };

      layer-rules = [
        (lib.mkIf config.desktop.noctalia.enable {
          matches = [ { namespace = "^noctalia-wallpaper*"; } ];
          place-within-backdrop = true;
        })
        {
          matches = [ { namespace = "^notifications$"; } ];
          block-out-from = "screen-capture";
        }
      ];

      layout = {
        gaps = 5;
        always-center-single-column = true;
        preset-column-widths = [
          { proportion = 0.5; }
          { proportion = 2. / 3.; }
          { proportion = 1. / 3.; }
        ];
        default-column-width.proportion = 0.5;
        border = {
          enable = true;
          width = 3;
        };
      };
      # hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      animations = {
        workspace-switch.enable = false;
        slowdown = 0.5;
      };

      workspaces = {
        "1".name = "terminal";
        "2".name = "browser";
        "3".name = "notes";
        "4".name = "music";
        "5".name = "chats";
      };
      spawn-at-startup = [
        { argv = [ "niriusd" ]; }
        { argv = [ "super-productivity" ]; }
        (lib.mkIf config.desktop.noctalia.enable { argv = [ "noctalia-shell" ]; })
        (lib.mkIf config.desktop.noctalia.enable { argv = [ "noctalia-performance" ]; })
      ];
      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 2.;
            bottom-right = 2.;
            top-left = 2.;
            top-right = 2.;
          };
          clip-to-geometry = true;
          open-focused = true;
        }
        # NOTE: This is where you put all the video games you want tearing in
        {
          matches = [
            { app-id = "^waywall$"; }
          ];
        }
        {
          matches = [
            {
              app-id = "firefox$";
              title = "^Picture-in-Picture";
            }
          ];
          open-floating = true;
        }
        {
          matches = [
            { app-id = "^org\\.keepassxc\\.KeePassXC$"; }
            { app-id = "^org\\.gnome\\.World\\.Secrets$"; }
          ];
          block-out-from = "screen-capture";
        }
        {
          matches = [
            { app-id = "^com\\.mitchellh\\.ghostty$"; }
          ];
          open-on-workspace = "terminal";
          default-column-width.proportion = 2. / 3.;
        }
        {
          matches = [
            { app-id = "^zen.*$"; }
          ];
          open-on-workspace = "browser";
          open-maximized = true;
        }
        {
          matches = [
            { app-id = "^superproductivity$"; }
          ];
          open-on-workspace = "notes";
          open-maximized = true;
        }
        {
          matches = [
            { app-id = "^com\\.github\\.th_ch\\.youtube_music$"; }
          ];
          open-on-workspace = "music";
          default-column-width.proportion = 2. / 3.;
        }
        {
          matches = [
            { app-id = "^vesktop$"; }
            { app-id = "^caprine$"; }
          ];
          open-on-workspace = "chats";
          default-column-width.proportion = 2. / 3.;
        }
        {
          matches = [
            {
              app-id = "^org\\.gnome\\.Nautilus$";
              is-floating = true;
            }
            { app-id = "^caprine$"; }
          ];
          default-column-width.proportion = 0.6;
          default-window-height.proportion = 0.7;
        }
      ];
      debug = {
        ignore-drm-device = "/dev/dri/card1";
        honor-xdg-activation-with-invalid-serial = lib.mkIf config.desktop.noctalia.enable [ ];
      };
      binds = {
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];
        "Mod+T" = {
          hotkey-overlay.title = "Open terminal";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "com.mitchellh.ghostty"
            "ghostty"
          ];
        };
        "Mod+Ctrl+T" = {
          hotkey-overlay.title = "Move terminal";
          repeat = false;
          action.spawn = [
            "nirius"
            "move-to-current-workspace-or-spawn"
            "--app-id"
            "com.mitchellh.ghostty"
            "--focus"
            "ghostty"
          ];
        };
        "Mod+B" = {
          hotkey-overlay.title = "Open browser";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "zen"
            "zen-beta"
          ];
        };
        "Mod+Ctrl+B" = {
          hotkey-overlay.title = "Move terminal";
          repeat = false;
          action.spawn = [
            "nirius"
            "move-to-current-workspace-or-spawn"
            "--app-id"
            "zen"
            "--focus"
            "zen"
          ];
        };
        "Mod+U" = {
          hotkey-overlay.title = "Open music";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "com.github.th_ch.youtube_music"
            "pear-desktop"
          ];
        };
        "Mod+Ctrl+U" = {
          hotkey-overlay.title = "Move music";
          repeat = false;
          action.spawn = [
            "nirius"
            "move-to-current-workspace-or-spawn"
            "--app-id"
            "com.github.th_ch.youtube_music"
            "--focus"
            "pear-desktop"
          ];
        };
        "Mod+D" = {
          hotkey-overlay.title = "Open Discord";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "vesktop"
            "vesktop"
          ];
        };
        "Mod+Ctrl+D" = {
          hotkey-overlay.title = "Move Discord";
          repeat = false;
          action.spawn = [
            "nirius"
            "move-to-current-workspace-or-spawn"
            "--app-id"
            "vesktop"
            "vesktop"
          ];
        };
        "Mod+M" = {
          hotkey-overlay.title = "Open Messenger";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "Caprine"
            "caprine"
          ];
        };
        "Mod+Ctrl+M" = {
          hotkey-overlay.title = "Move Messenger";
          repeat = false;
          action.spawn = [
            "nirius"
            "move-to-current-workspace-or-spawn"
            "--app-id"
            "Caprine"
            "caprine"
          ];
        };
        "Mod+S" = {
          hotkey-overlay.title = "Open Super Productivity";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "superProductivity"
            "super-productivity"
          ];
        };
        "Mod+Ctrl+S" = {
          hotkey-overlay.title = "Move Super Productivity";
          repeat = false;
          action.spawn = [
            "nirius"
            "move-to-current-workspace-or-spawn"
            "--app-id"
            "superProductivity"
            "super-productivity"
          ];
        };
        "Mod+K" = {
          hotkey-overlay.title = "Open KeepassXC";
          repeat = false;
          action.spawn = [
            "nirius"
            "focus-or-spawn"
            "--app-id"
            "org.keepassxc.KeePassXC"
            "keepassxc"
          ];
        };
        "Ctrl+Escape" = lib.mkIf config.desktop.noctalia.enable {
          hotkey-overlay.title = "Open launcher";
          repeat = false;
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "launcher"
            "toggle"
          ];
        };
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.5";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        };
        "XF86AudioPlay" = lib.mkIf config.desktop.noctalia.enable {
          allow-when-locked = true;
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "media"
            "playPause"
          ];
        };
        "XF86AudioNext" = lib.mkIf config.desktop.noctalia.enable {
          allow-when-locked = true;
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "media"
            "next"
          ];
        };
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "--exponent=5"
            "-n"
            "set"
            "+2%"
          ];
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = [
            "brightnessctl"
            "--class=backlight"
            "--exponent=5"
            "-n"
            "set"
            "2%-"
          ];
        };
        "Mod+Q" = lib.mkIf config.desktop.noctalia.enable {
          hotkey-overlay.title = "Open the session menu";
          repeat = false;
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "sessionMenu"
            "toggle"
          ];
        };
        "Mod+Shift+Q" = {
          hotkey-overlay.title = "Power off monitors";
          action.power-off-monitors = [ ];
        };
        "Mod+Ctrl+Q" = {
          hotkey-overlay.title = "Exit niri";
          repeat = false;
          action.quit = [
          ];
        };
        "Mod+I" = lib.mkIf config.desktop.noctalia.enable {
          hotkey-overlay.title = "Inhibit idle";
          repeat = false;
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "idleInhibitor"
            "toggle"
          ];
        };
        "Mod+O" = {
          hotkey-overlay.title = "Toggle overview";
          repeat = false;
          action.toggle-overview = [ ];
        };
        "Mod+P" = lib.mkIf config.desktop.noctalia.enable {
          hotkey-overlay.title = "Cycle power profiles";
          repeat = false;
          action.spawn = [
            "noctalia-shell"
            "ipc"
            "call"
            "powerProfile"
            "toggle"
          ];
        };
        "Mod+W" = {
          repeat = false;
          action.close-window = [ ];
        };
        "Alt+Tab".action.focus-workspace-previous = [ ];

        "Mod+Left".action.focus-column-left = [ ];
        "Mod+Down".action.focus-window-down = [ ];
        "Mod+Up".action.focus-window-up = [ ];
        "Mod+Right".action.focus-column-right = [ ];
        "Mod+Ctrl+Left".action.move-column-left = [ ];
        "Mod+Ctrl+Down".action.move-window-down = [ ];
        "Mod+Ctrl+Up".action.move-window-up = [ ];
        "Mod+Ctrl+Right".action.move-column-right = [ ];

        "Mod+Home".action.focus-column-first = [ ];
        "Mod+End".action.focus-column-last = [ ];
        "Mod+Ctrl+Home".action.move-column-to-first = [ ];
        "Mod+Ctrl+End".action.move-column-to-last = [ ];

        "Mod+Shift+Left".action.focus-monitor-left = [ ];
        "Mod+Shift+Down".action.focus-monitor-down = [ ];
        "Mod+Shift+Up".action.focus-monitor-up = [ ];
        "Mod+Shift+Right".action.focus-monitor-right = [ ];
        "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = [ ];
        "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = [ ];
        "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = [ ];
        "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = [ ];

        "Mod+Page_Down".action.focus-workspace-down = [ ];
        "Mod+Page_Up".action.focus-workspace-up = [ ];
        "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = [ ];
        "Mod+Shift+Page_Down".action.move-workspace-down = [ ];
        "Mod+Shift+Page_Up".action.move-workspace-up = [ ];

        # "Mod+WheelScrollRight".action.focus-column-right = [ ];
        # "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        # "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
        # "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];
        "Mod+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Ctrl+WheelScrollDown".action.move-column-right = [ ];
        "Mod+Ctrl+WheelScrollUp".action.move-column-left = [ ];
        "Mod+Shift+WheelScrollDown".action.focus-workspace-down = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-workspace-up = [ ];
        "Mod+Shift+Ctrl+WheelScrollDown".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+Ctrl+WheelScrollUp".action.move-column-to-workspace-up = [ ];

        "Mod+1".action.focus-workspace = [ 1 ];
        "Mod+2".action.focus-workspace = [ 2 ];
        "Mod+3".action.focus-workspace = [ 3 ];
        "Mod+4".action.focus-workspace = [ 4 ];
        "Mod+5".action.focus-workspace = [ 5 ];
        "Mod+6".action.focus-workspace = [ 6 ];
        "Mod+7".action.focus-workspace = [ 7 ];
        "Mod+8".action.focus-workspace = [ 8 ];
        "Mod+9".action.focus-workspace = [ 9 ];
        "Mod+0".action.focus-workspace = [ 10 ];
        "Mod+Ctrl+1".action.move-column-to-workspace = [ 1 ];
        "Mod+Ctrl+2".action.move-column-to-workspace = [ 2 ];
        "Mod+Ctrl+3".action.move-column-to-workspace = [ 3 ];
        "Mod+Ctrl+4".action.move-column-to-workspace = [ 4 ];
        "Mod+Ctrl+5".action.move-column-to-workspace = [ 5 ];
        "Mod+Ctrl+6".action.move-column-to-workspace = [ 6 ];
        "Mod+Ctrl+7".action.move-column-to-workspace = [ 7 ];
        "Mod+Ctrl+8".action.move-column-to-workspace = [ 8 ];
        "Mod+Ctrl+9".action.move-column-to-workspace = [ 9 ];
        "Mod+Ctrl+0".action.move-column-to-workspace = [ 10 ];

        "Mod+Alt+Left".action.consume-or-expel-window-left = [ ];
        "Mod+Alt+Right".action.consume-or-expel-window-right = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];

        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+R".action.switch-preset-window-height = [ ];
        "Mod+Ctrl+R".action.reset-window-height = [ ];
        "Mod+Ctrl+F".action.maximize-window-to-edges = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];

        "Mod+C".action.center-column = [ ];
        "Mod+Ctrl+C".action.center-visible-columns = [ ];

        "Mod+Minus".action.set-column-width = [ "-10%" ];
        "Mod+Equal".action.set-column-width = [ "+10%" ];
        "Mod+Shift+Minus".action.set-window-height = [ "-10%" ];
        "Mod+Shift+Equal".action.set-window-height = [ "+10%" ];

        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];

        "Print".action.screenshot = [ ];
        "Shift+Print".action.screenshot-screen = [ ];
        "Alt+Print".action.spawn = [ "ocr" ];
        "Ctrl+Print".action.spawn = [ "${pkgs.woomer}/bin/woomer" ];

        "Mod+Escape" = {
          allow-inhibiting = false;
          action.toggle-keyboard-shortcuts-inhibit = [ ];
        };
      };
    };

    ## Niri
    # xdg.configFile."niri/base16.kdl".text =
    #   with config.lib.stylix.colors.withHashtag;
    #   lib.mkIf config.desktop.niri.enable ''
    #     output "eDP-1" {
    #         layout {
    #             background-color "${base00}"
    #         }
    #     }
    #
    #     overview {
    #       backdrop-color "${base01}"
    #     }
    #     layout {
    #         focus-ring {
    #             active-color   "${base0B}"
    #             inactive-color "${base00}"
    #             urgent-color   "${base08}"
    #         }
    #
    #         border {
    #             active-color   "${base0B}"
    #             inactive-color "${base00}"
    #             urgent-color   "${base08}"
    #         }
    #
    #         shadow {
    #             color "#00000070"
    #         }
    #
    #         tab-indicator {
    #             active-color   "${base0B}"
    #             inactive-color "${base00}"
    #             urgent-color   "${base08}"
    #         }
    #
    #         insert-hint {
    #             color "#98971a80"
    #         }
    #     }
    #
    #     cursor {
    #        xcursor-theme "${config.stylix.cursor.name}"
    #        xcursor-size ${toString config.stylix.cursor.size}
    #     }
    #   '';
  };
}
