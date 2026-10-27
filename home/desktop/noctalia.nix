{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    desktop.noctalia.enable = lib.mkEnableOption "enables noctalia";
  };

  imports = [ inputs.noctalia.homeModules.default ];
  config = lib.mkIf config.desktop.noctalia.enable {
    home.packages = with pkgs; [
      notify-desktop
      udiskie
      wdisplays
      wl-mirror
      (writers.writeDashBin "noctalia-performance" ''
        ${inputs.ppd-dbus-hook.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ppd-dbus-hook \
          "${
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          }/bin/noctalia msg plugin \"detluck/performance-plus:service\" all disable" \
          "${
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          }/bin/noctalia msg plugin \"detluck/performance-plus:service\" all disable" \
          "${
            inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          }/bin/noctalia msg plugin \"detluck/performance-plus:service\" all enable"
      '')
    ];

    programs.noctalia = {
      enable = true;
      # https://github.com/erooke/toml2nix
      # nix run github:erooke/toml2nix
      settings = {
        audio = {
          enable_overdrive = true;
        };
        backdrop = {
          enabled = true;
        };
        bar = {
          order = [ "default" ];
          default = {
            capsule = true;
            center = [
              "clock"
              "media"
            ];
            enabled = true;
            end = [
              "privacy"
              "sysmon"
              "network"
              "volume"
              "battery"
            ];
            margin_ends = 0;
            position = "left";
            radius = 6;
            start = [
              "control-center"
              "launcher"
              "workspaces"
              "tray"
              "status"
            ];
            thickness = 42;
          };
        };
        battery = {
          warning_threshold = 20;
        };
        brightness = {
          minimum_brightness = 0.009999999776482582;
          sync_all_monitors = true;
        };
        control_center = {
          hidden_tabs = [ "weather" ];
          sidebar = "full";
          shortcuts = [
            {
              type = "wifi";
            }
            {
              type = "caffeine";
            }
            {
              type = "nightlight";
            }
            {
              type = "notification";
            }
            {
              type = "power_profile";
            }
            {
              type = "elijaharch/wl-screen-mirror:toggle";
            }
          ];
        };
        desktop_widgets = {
          schema_version = 2;
          widget_order = [
            "desktop-widget-0000000000000001"
            "desktop-widget-0000000000000002"
          ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            desktop-widget-0000000000000001 = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 168.0;
              cy = 1020.0;
              output = "eDP-1";
              placement_height = 1080.0;
              placement_width = 1920.0;
              rotation = 0.0;
              type = "audio_visualizer";
              settings = {
                background = false;
                bands = 32;
                mirrored = false;
                show_when_idle = true;
              };
            };
            desktop-widget-0000000000000002 = {
              box_height = 0.0;
              box_width = 0.0;
              cx = 1762.0;
              cy = 1033.5;
              output = "eDP-1";
              placement_height = 1080.0;
              placement_width = 1920.0;
              rotation = 0.0;
              type = "label";
              settings = {
                background = false;
                title = "You can keep going.";
              };
            };
          };
        };
        idle = {
          behavior_order = [
            "screen-off"
            "lock"
            "lock-and-suspend"
          ];
          pre_action_fade_seconds = 10;
          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 180.0;
            };
            lock-and-suspend = {
              action = "lock_and_suspend";
              enabled = true;
              timeout = 300.0;
            };
            screen-off = {
              action = "screen_off";
              enabled = true;
              locked_timeout = 20.0;
              timeout = 120.0;
            };
          };
        };
        location = {
          custom_schedule = true;
          sunrise = "06:00";
          sunset = "21:00";
        };
        lockscreen_widgets = {
          enabled = false;
          schema_version = 2;
          widget_order = [ "lockscreen-login-box@eDP-1" ];
          grid = {
            cell_size = 16;
            major_interval = 4;
            visible = true;
          };
          widget = {
            "lockscreen-login-box@eDP-1" = {
              box_height = 196.0;
              box_width = 810.0;
              cx = 960.0;
              cy = 898.0;
              output = "eDP-1";
              placement_height = 1080.0;
              placement_width = 1920.0;
              rotation = 0.0;
              type = "login_box";
              settings = {
                background_color = "surface_variant";
                background_opacity = 0.88;
                background_radius = 12.0;
                center_password_text = false;
                input_opacity = 1.0;
                input_radius = 6.0;
                layout = "regular";
                show_caps_lock = true;
                show_keyboard_layout = true;
                show_login_button = true;
                show_media = true;
                show_password_reveal = true;
                show_session_buttons = true;
                show_unlock_hint = true;
                show_weather = true;
              };
            };
          };
        };
        nightlight = {
          enabled = true;
          temperature_night = 1000;
        };
        plugin_settings = {
          "notfinaldev/web-search" = {
            provider = "duckduckgo";
          };
          "detluck/performance-plus" = {
            set_power_profile = false;
          };
        };
        plugins = {
          enabled = [
            "aristides/udiskie"
            "detluck/performance-plus"
            "elijaharch/wl-screen-mirror"
            "nightwatch75/file-search"
            "notfinaldev/web-search"
          ];
        };
        shell = {
          app_icon_color = "on_surface";
          corner_radius_scale = 0.4000000059604645;
          font_family = "Aporetic Sans";
          launch_apps_as_systemd_services = true;
          niri_overview_close_on_launch_enabled = true;
          niri_overview_type_to_launch_enabled = true;
          polkit_agent = true;
          panel = {
            open_near_click_control_center = true;
            session_placement = "floating";
            session_position = "center";
          };
        };
        system = {
          monitor = {
            cpu_temp_activity_threshold = 80;
            cpu_temp_critical_threshold = 90;
          };
        };
        wallpaper = {
          directory = "/home/gravity/Pictures/Wallpapers";
          transition_on_startup = true;
          # default = {
          #   path = "/home/gravity/Pictures/Wallpapers/Tranquility.png";
          # };
          # last = {
          #   path = "/home/gravity/Pictures/Wallpapers/Tranquility.png";
          # };
          # monitors = {
          #   eDP-1 = {
          #     path = "/home/gravity/Pictures/Wallpapers/Tranquility.png";
          #   };
          # };
        };
        weather = {
          enabled = false;
        };
        widget = {
          clock = {
            anchor = true;
            font_scale = 1.2;
            format = "{:%I:%M:%p}";
          };
          media = {
            hide_when_no_media = true;
          };
          privacy = {
            hide_inactive = true;
          };
          status = {
            hide_when_empty = true;
            type = "aristides/udiskie:status";
          };
          sysmon = {
            show_value = false;
            stat = "disk_used_pct";
          };
          tray = {
            drawer = true;
          };
          workspaces = {
            font_scale = 1.2;
          };
        };
      };
    };
  };
}
