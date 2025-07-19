{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome-epub-thumbnailer
    gnomeExtensions.alttab-mod
    # https://extensions.gnome.org/extension/2741/remove-alttab-delay-v2/
    gnomeExtensions.remove-alttab-delay-v2
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.freon
    # gnomeExtensions.luminus-desktop
    gnomeExtensions.pop-shell
    gnomeExtensions.run-or-raise
    gnomeExtensions.switch-workspace
    gnomeExtensions.tomatoc-to-panel
    gnomeExtensions.workspaces-indicator-by-open-apps
  ];

  # Gnome settings

  dconf.settings = {
    "org/gnome/desktop/session".idle-delay = 300;
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/peripherals/mouse".speed = -0.6;
    "org/gnome/desktop/peripherals/keyboard".repeat = true;
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      num-workspaces = 9;
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      color-scheme = "prefer-dark";
      accent-color = "purple";
      font-name = "Aporetic Sans 11";
      enable-animations = false;
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
      switch-applications = [ "<Super>Tab" ];
      switch-applications-backward = [ "<Shift><Super>Tab" ];
      switch-group = [ "<Super>grave" ];
      switch-group-backward = [ "<Shift><Super>grave" ];
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
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
      "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    ];
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control>Print";
      command = "normcap --clipboard-handler=wlclipboard";
      name = "OCR with normcap";
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
      disable-extension-version-validation = true;
      disable-user-extensions = false;
      disabled-extensions = [ ];
      favorite-apps = [ "" ];
      enabled-extensions = [
        "alttab-mod@leleat-on-github"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "freon@UshakovVasilii_Github.yahoo.com"
        # "luminus-desktop@dikasp.gitlab"
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
    "org/gnome/shell/extensions/pop-shell" = {
      active-hint = true;
      # active-hint-border-radius = 16;
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
      switch-workspace = [ "<Alt>Tab" ];
      switch-workspace-backward = [ "<Shift><Alt>Tab" ];
    };
    "org/gnome/shell/extensions/workspaces-indicator-by-open-apps" = {
      indicator-color = "rgb(87,82,121)";
      indicator-show-indexes = true;
      size-app-icon = 24;
      spacing-app-left = 1;
      spacing-app-right = 1;
    };
  };
}
