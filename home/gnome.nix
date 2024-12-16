{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome-epub-thumbnailer
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    # gnomeExtensions.forge
    gnomeExtensions.pop-shell
    gnomeExtensions.run-or-raise
  ];
  # Gnome settings
  dconf.settings = {
    "org/gnome/desktop/session".idle-delay = 300;
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>w" ];
      toggle-maximized = [ "<Super>f" ];
      maximize = [ "" ];
      unmaximize = [ "" ];
      switch-group = [ "" ];
      switch-group-backward = [ "" ];
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      color-scheme = "default";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = true;
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-ac-timeout = 900;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
    };
    "org/gnome/mutter/wm/keybindings" = {
      toggle-tiled-right = [ "" ];
      toggle-tiled-left = [ "" ];
    };
    "org/gnome/shell" = {
      # "app-switcher".current-workspace-only = false;
      disable-user-extensions = false;
      # `gnome-extensions list` for a list
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        # "forge@jmmaranan.com"
        "pop-shell@system76.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "run-or-raise@edvard.cz"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      show-trash = false;
      hot-keys = true;
      shortcut = [ "<Super>grave" ];
      shortcut-text = "<Super>grave";
    };
    # "org/gnome/shell/extensions/forge" = {
    #   move-pointer-focus-enabled = false;
    #   window-gap-size = 2;
    # };
    # "org/gnome/shell/extensions/forge/keybindings" = {
    #   window-focus-down = [ "<Super>Down" ];
    #   window-move-down = [ "<Shift><Super>Down" ];
    #   window-focus-up = [ "<Super>Up" ];
    #   window-move-up = [ "<Shift><Super>Up" ];
    #   window-focus-right = [ "<Super>Right" ];
    #   window-move-right = [ "<Shift><Super>Right" ];
    #   window-focus-left = [ "<Super>Left" ];
    #   window-move-left = [ "<Shift><Super>Left" ];
    # };

    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = true;
      active-hint = true;
      active-hint-color = "#FFFFFF";
      # gap-inner = 1;
    };
  };
}
