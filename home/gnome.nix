{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome-epub-thumbnailer
    gnomeExtensions.alttab-mod
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.freon
    gnomeExtensions.luminus-desktop
    gnomeExtensions.pop-shell
    gnomeExtensions.run-or-raise
    gnomeExtensions.switch-workspace
    gnomeExtensions.tomatoc-to-panel
    gnomeExtensions.workspaces-indicator-by-open-apps
  ];

  # Gnome settings

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/gravity/.local/share/backgrounds/2025-05-22-11-27-14-blockwavedawn.png";
      picture-uri-dark = "file:///home/gravity/.local/share/backgrounds/2025-05-22-11-27-14-blockwavedawn.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/gravity/.local/share/backgrounds/2025-05-22-11-27-14-blockwavedawn.png";
      picture-uri-dark = "file:///home/gravity/.local/share/backgrounds/2025-05-22-11-27-14-blockwavedawn.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };
    "org/gnome/desktop/session".idle-delay = 300;
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/peripherals/mouse".speed = -0.6;
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      num-workspaces = 9;
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      color-scheme = "prefer-light";
      font-name = "Aporetic Sans 11";
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      move-to-workspace-1 = [ "<Shift><Super>1" ];
      move-to-workspace-2 = [ "<Shift><Super>2" ];
      move-to-workspace-3 = [ "<Shift><Super>3" ];
      move-to-workspace-4 = [ "<Shift><Super>4" ];
      move-to-workspace-5 = [ "<Shift><Super>5" ];
      move-to-workspace-6 = [ "<Shift><Super>6" ];
      move-to-workspace-7 = [ "<Shift><Super>7" ];
      move-to-workspace-8 = [ "<Shift><Super>8" ];
      move-to-workspace-9 = [ "<Shift><Super>9" ];
      close = [ "<Super>w" ];
      toggle-maximized = [ "<Super>f" ];
      maximize = [ "" ];
      unmaximize = [ "" ];
      switch-applications = [ "<Alt>Tab" ];
      switch-applications-backward = [ "<Shift><Alt>Tab" ];
      switch-group = [ "" ];
      switch-group-backward = [ "" ];
      switch-windows = [ "" ];
      switch-windows-backward = [ "" ];
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = true;
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-ac-timeout = 900;
    };

    "org/gnome/mutter" = {
      focus-change-on-pointer-rest = false;
      dynamic-workspaces = true;

      edge-tiling = true;
      experimental-features = [
        "scale-monitor-framebuffer"
        "xwayland-native-scaling"
      ];

      workspaces-only-on-primary = true;
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-right = [ "" ];
      toggle-tiled-left = [ "" ];
    };

    "org/gnome/shell" = {
      # `gnome-extensions list` for a list
      disable-user-extensions = false;
      disable-extension-version-validation = true;
      favorite-apps = [ "" ];
      enabled-extensions = [
        "alttab-mod@leleat-on-github"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "executor@raujonas.github.io"
        "freon@UshakovVasilii_Github.yahoo.com"
        "luminus-desktop@dikasp.gitlab"
        "pop-shell@system76.com"
        "run-or-raise@edvard.cz"
        "switchWorkSpace@sun.wxg@gmail.com"
        "tomato-c-to-panel@thomas-philippot.dev"
        "workspaces-by-open-apps@favo02.github.com"
      ];
    };

    "org/gnome/shell/keybindings" = {
      "switch-to-application-1" = [ "" ];
      "switch-to-application-2" = [ "" ];
      "switch-to-application-3" = [ "" ];
      "switch-to-application-4" = [ "" ];
      "switch-to-application-5" = [ "" ];
      "switch-to-application-6" = [ "" ];
      "switch-to-application-7" = [ "" ];
      "switch-to-application-8" = [ "" ];
      "switch-to-application-9" = [ "" ];
      "toggle-application-view" = [ "" ];
    };

    # Extensions
    "org/gnome/shell/extensions/dash-to-dock" = {
      hot-keys = false;
      show-dock-urgent-notify = false;
      show-trash = false;
      # shortcut = [ "<Super>grave" ];
      # shortcut-text = "<Super>grave";
    };
    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      # active-hint-border-radius = "uint 16";
      hint-color-rgba = "rgba(87, 82, 121, 255)";
      tile-by-default = true;
    };
    "org/gnome/shell/extensions/caffeine" = {
      toggle-shortcut = [ "" ];
      show-notifications = false;
    };
    "org/gnome/shell/extensions/freon" = {
      hot-sensors = [ "__max__" ];
      use-gpu-nvidia = false;
    };
    "org/gnome/shell/extensions/altTab-mod" = {
      current-workspace-only-window = false;
      raise-first-instance-only = false;
      remove-delay = true;
    };
    "org/gnome/shell/extensions/switchWorkSpace" = {
      switch-workspace = [ "<Super>Tab" ];
      switch-workspace-backward = [ "<Shift><Super>Tab" ];
    };
    "org/gnome/shell/extensions/workspaces-indicator-by-open-apps" = {
      indicator-color = "rgb(87,82,121)";
      indicator-show-indexes = true;
      size-app-icon = 24;
      spacing-app-left = 1;
      spacing-app-right = 1;
    };

    # "org/gnome/shell/extensions/executor" = {
    #   right-active = false;
    #   left-active = false;
    #   center-active = true;
    #   center-commands-json = "{\"commands\":[{\"isActive\":true,\"command\":\"tomato -t\",\"interval\":1,\"uuid\":\"c2f225a9-1b95-4f82-b5c6-ce9e42a5a767\"}]}";
    # };
  };
}
