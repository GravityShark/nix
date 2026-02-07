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

    stylix.cursor = {
      # package = pkgs.bibata-cursors;
      # package = pkgs.nordzy-cursor-theme;
      # name = lib.mkDefault "Nordzy-cursors";
      package = pkgs.banana-cursor;
      name = lib.mkDefault "Banana";
      size = 46;
    };

    stylix.icons.enable = true;
    stylix.icons.package = pkgs.papirus-icon-theme;
    stylix.icons.light = "Papirus-Light";
    stylix.icons.dark = "Papirus-Dark";

    stylix.autoEnable = false;
    stylix.targets = {
      anki.enable = true;
      # fish.enable = true; currently annoying with fish 4.3.0, because a message appears
      fontconfig.enable = true;
      fzf.enable = true;
      ghostty.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      gtksourceview.enable = true;
      kde.enable = true;
      # mangohud.enable = true;
      # mpv.enable = true;
      # neovim.enable = true;
      noctalia-shell.enable = true;
      # obsidian = {
      #   enable = true;
      #   fonts.override.sizes.desktop = 16;
      # };
      qt.enable = true;
      vesktop.enable = true;
      zathura.enable = true;
      zen-browser = {
        enable = true;
        profileNames = [ "Default Profile" ];
      };
    };

    xdg.configFile = {
      ## Niri
      "niri/base16.kdl".text = with config.lib.stylix.colors.withHashtag; ''
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
           xcursor-size ${builtins.toString config.stylix.cursor.size}
        }
      '';

      ## Add the mini.base16 colorscheme
      # "nvim/colors/nix.lua".source =
      #   with config.lib.stylix.colors.withHashtag;
      #   # Ony activate if neovim is enabled
      #   lib.mkIf config.apps.neovim.enable (
      #     pkgs.replaceVars ../../dump/.config/nvim/colors/nix.lua {
      #       base00 = "${base00}";
      #       base01 = "${base01}";
      #       base02 = "${base02}";
      #       base03 = "${base03}";
      #       base04 = "${base04}";
      #       base05 = "${base05}";
      #       base06 = "${base06}";
      #       base07 = "${base07}";
      #       base08 = "${base08}";
      #       base09 = "${base09}";
      #       base0A = "${base0A}";
      #       base0B = "${base0B}";
      #       base0C = "${base0C}";
      #       base0D = "${base0D}";
      #       base0E = "${base0E}";
      #       base0F = "${base0F}";
      #     }
      #   );
    };

    ## Extra noctalia-shell
    programs.noctalia-shell.settings = lib.mkIf config.stylix.targets.noctalia-shell.enable {
      bar.backgroundOpacity = config.stylix.opacity.desktop;
      bar.capsuleOpacity = config.stylix.opacity.desktop;
      ui.panelBackgroundOpacity = config.stylix.opacity.desktop;
      dock.backgroundOpacity = config.stylix.opacity.desktop;
      osd.backgroundOpacity = config.stylix.opacity.popups;
      notifications.backgroundOpacity = config.stylix.opacity.popups;
      colorSchemes.darkMode = lib.mkForce (config.stylix.polarity != "light");
    };
  };
}
