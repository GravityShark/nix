{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

{
  options = {
    desktop.stylix.enable = lib.mkEnableOption "enables stylix";

    desktop.stylix.theme = lib.mkOption {
      type = lib.types.nullOr (
        lib.types.enum [
          "gruvbox-material-light"
          "rose-pine"
        ]
      );
      default =
        lib.throwIf config.desktop.stylix.enable
          "Use a predefined theme when stylix is used: gruvbox-material-light, rose-pine"
          null;
      description = "Type of predefined theme to be used. gruvbox-material-light, rose-pine";
      example = "gruvbox-material-light";
    };

  };

  imports = [
    inputs.stylix.homeModules.stylix
    ./stylix/gruvbox-material-light.nix
    ./stylix/rose-pine.nix
  ];

  config = lib.mkIf (config.desktop.stylix.enable) {
    # https://nix-community.github.io/stylix/configuration.html
    stylix.enable = true;

    stylix.fonts = {
      sizes = {
        applications = 11;
        # desktop = 10;
        # popups = 10;
        terminal = 13;
      };

      serif = {
        package = pkgs.aporetic;
        name = "Aporetic Serif";
      };
      sansSerif = {
        package = pkgs.aporetic;
        name = "Aporetic Sans";
      };
      monospace = {
        package = pkgs.aporetic;
        name = "Aporetic Sans Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    stylix.cursor =
      if (config.stylix.polarity == "light") then
        {
          package = pkgs.callPackage ../packages/golden-xcursor.nix { };
          name = "GoldenXMod";
          size = 48;
        }
      else
        {
          package = pkgs.callPackage ../packages/silver-xcursor.nix { };
          name = "SilverXMod";
          size = 48;
        };

    stylix.icons.enable = true;
    stylix.icons.package = pkgs.papirus-icon-theme;
    stylix.icons.light = "Papirus-Light";
    stylix.icons.dark = "Papirus-Dark";

    stylix.autoEnable = false;
    stylix.targets = {
      anki.enable = config.apps.anki.enable;
      fontconfig.enable = true;
      fzf.enable = config.apps.fzf.enable;
      ghostty.enable = config.apps.ghostty.enable;
      gnome.enable = true;
      gtk.enable = true;
      gtksourceview.enable = true;
      kde.enable = true;
      mpv.enable = config.programs.mpv.enable;
      noctalia-shell.enable = config.desktop.noctalia.enable;
      qt.enable = true;
      vesktop.enable = config.programs.vesktop.enable;
      zathura.enable = config.programs.zathura.enable;
      zen-browser = {
        enable = config.apps.zen-browser.enable;
        profileNames = [ "Default Profile" ];
      };
    };

    ## Labwc
    wayland.windowManager.labwc.environment = lib.mkIf config.wayland.windowManager.labwc.enable [
      "XCURSOR_THEME=${config.stylix.cursor.name}"
      "XCURSOR_SIZE=${toString config.stylix.cursor.size}"
    ];

    ## Noctalia-shell
    programs.noctalia-shell.settings = lib.mkIf config.stylix.targets.noctalia-shell.enable {
      bar.backgroundOpacity = lib.mkForce config.stylix.opacity.desktop;
      bar.capsuleOpacity = lib.mkForce config.stylix.opacity.desktop;
      colorSchemes.darkMode = lib.mkForce (config.stylix.polarity != "light");
      dock.backgroundOpacity = lib.mkForce config.stylix.opacity.desktop;
      notifications.backgroundOpacity = lib.mkForce config.stylix.opacity.popups;
      osd.backgroundOpacity = lib.mkForce config.stylix.opacity.popups;
      ui.panelBackgroundOpacity = lib.mkForce config.stylix.opacity.desktop;
      wallpaper.directory = lib.mkForce "/home/${config.home.username}/Pictures/Wallpapers";
      wallpaper.fillColor = lib.mkForce "${config.lib.stylix.colors.withHashtag.base00}";
    };
  };
}
