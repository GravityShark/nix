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
      anki.enable = true;
      fish.enable = true; # NOTE: currently annoying with fish 4.3.0, because a message appears
      fontconfig.enable = true;
      fzf.enable = true;
      ghostty.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      gtksourceview.enable = true;
      kde.enable = true;
      # mangohud.enable = true;
      mpv.enable = true;
      noctalia-shell.enable = true;
      qt.enable = true;
      vesktop.enable = true;
      zathura.enable = true;
      zen-browser = {
        enable = true;
        profileNames = [ "Default Profile" ];
      };
    };

    ## Niri
    xdg.configFile."niri/base16.kdl".text =
      with config.lib.stylix.colors.withHashtag;
      lib.mkIf config.desktop.niri.enable ''
        output "eDP-1" {
            layout {
                background-color "${base00}"
            }
        }

        overview {
          backdrop-color "${base01}"
        }
        layout {
            focus-ring {
                active-color   "${base0B}"
                inactive-color "${base00}"
                urgent-color   "${base08}"
            }

            border {
                active-color   "${base0B}"
                inactive-color "${base00}"
                urgent-color   "${base08}"
            }

            shadow {
                color "#00000070"
            }

            tab-indicator {
                active-color   "${base0B}"
                inactive-color "${base00}"
                urgent-color   "${base08}"
            }

            insert-hint {
                color "#98971a80"
            }
        }

        cursor {
           xcursor-theme "${config.stylix.cursor.name}"
           xcursor-size ${toString config.stylix.cursor.size}
        }
      '';

    ## Labwc
    wayland.windowManager.labwc.environment = lib.mkIf config.wayland.windowManager.labwc.enable [
      "XCURSOR_THEME=${config.stylix.cursor.name}"
      "XCURSOR_SIZE=${toString config.stylix.cursor.size}"
    ];

    ## Noctalia-shell
    programs.noctalia-shell.settings = lib.mkIf config.stylix.targets.noctalia-shell.enable {
      bar.backgroundOpacity = lib.mkForce config.stylix.opacity.desktop;
      bar.capsuleOpacity = config.stylix.opacity.desktop;
      ui.panelBackgroundOpacity = lib.mkForce config.stylix.opacity.desktop;
      dock.backgroundOpacity = lib.mkForce config.stylix.opacity.desktop;
      osd.backgroundOpacity = lib.mkForce config.stylix.opacity.popups;
      notifications.backgroundOpacity = lib.mkForce config.stylix.opacity.popups;
      colorSchemes.darkMode = lib.mkForce (config.stylix.polarity != "light");
    };
  };
}
