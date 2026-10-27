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
          package = pkgs.google-cursor;
          name = "GoogleDot-Black";
          size = 40;
        }
      else
        {
          package = pkgs.google-cursor;
          name = "GoogleDot-White";
          size = 40;
        };

    # if (config.stylix.polarity == "light") then
    #   {
    #     package = pkgs.callPackage ../packages/golden-xcursor.nix { };
    #     name = "GoldenXMod";
    #     size = 48;
    #   }
    # else
    #   {
    #     package = pkgs.callPackage ../packages/silver-xcursor.nix { };
    #     name = "SilverXMod";
    #     size = 48;
    #   };

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
      mangohud.enable = config.programs.mangohud.enable;
      mpv.enable = config.programs.mpv.enable;
      noctalia.enable = config.desktop.noctalia.enable;
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

    programs.noctalia.settings = lib.mkIf config.stylix.targets.noctalia.enable {
      wallpaper = {
        default = {
          path = config.stylix.image;
        };
        last = {
          path = config.stylix.image;
        };
        monitors = {
          eDP-1 = {
            path = config.stylix.image;
          };
        };
      };
    };
  };
}
