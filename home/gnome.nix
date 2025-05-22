{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome-epub-thumbnailer
    gnomeExtensions.alttab-mod
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.freon
    gnomeExtensions.highlight-focus
    gnomeExtensions.luminus-desktop
    gnomeExtensions.paperwm
    # gnomeExtensions.pop-shell
    gnomeExtensions.run-or-raise
    gnomeExtensions.switch-workspace
    gnomeExtensions.workspaces-indicator-by-open-apps
  ];
  # Gnome settings

  dconf.settings = {
    "org/gnome/desktop/session".idle-delay = 300;
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/peripherals/mouse".speed = -0.6;
    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "sloppy";
      num-workspaces = 9;
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
      switch-group = [ "" ];
      switch-group-backward = [ "" ];
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      color-scheme = "prefer-light";
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
      # "app-switcher".current-workspace-only = false;
      disable-user-extensions = false;
      # `gnome-extensions list` for a list
      favorite-apps = [ "" ];
      enabled-extensions = [
        "alttab-mod@leleat-on-github"
        "appindicatorsupport@rgcjonas.gmail.com"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "freon@UshakovVasilii_Github.yahoo.com"
        # "light-style@gnome-shell-extensions.gcampax.github.com"
        "pop-shell@system76.com"
        "run-or-raise@edvard.cz"
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

    "org/gnome/shell/extensions/dash-to-dock" = {
      show-trash = false;
      hot-keys = false;
      # shortcut = [ "<Super>grave" ];
      # shortcut-text = "<Super>grave";
    };
    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = true;
      active-hint = false;
      hint-color-rgba = "rgba(196, 167, 231, 255)";
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
      remove-delay = true;
      current-workspace-only-window = false;
      raise-first-instance-only = false;
    };
  };
}
