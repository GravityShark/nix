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
        # (lib.mkIf config.desktop.noctalia.enable {
        #   matches = [ { namespaces = "^noctalia-wallpaper*"; } ];
        #   place-within-backdrop = true;
        # })
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
        # focus-ring = {
        #   enable = true;
        #   width = 3;
        # };
        border = {
          width = 3;
          enable = true;
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
        "terminal" = { };
        "browser" = { };
        "notes" = { };
        "music" = { };
        "chats" = { };
      };
      spawn-at-startup = [
        { argv = [ "niriusd" ]; }
        { argv = [ "super-productivity" ]; }
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
            { app-id = "^zen.*"; }
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
      };
    };

    # xdg.configFile."niri/config.kdl".text =
    #   builtins.readFile ../../dump/.config/niri/config.kdl
    #   + (
    #     if config.desktop.noctalia.enable then
    #       ''
    #         spawn-at-startup "noctalia-shell"
    #         spawn-at-startup "noctalia-performance"
    #       ''
    #     else
    #       ""
    #   );

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
