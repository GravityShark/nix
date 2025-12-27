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
  };

  imports = [
    inputs.stylix.homeModules.stylix
    # ./stylix/gruvbox-material.nix
    ../stylix/rose-pine.nix
  ];

  config = lib.mkIf config.desktop.stylix.enable {
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
      package = pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Original-Classic";
      size = 12;
    };

    stylix.icons.enable = true;
    stylix.icons.package = pkgs.papirus-icon-theme;
    stylix.icons.light = "Papirus-Light";
    stylix.icons.dark = "Papirus-Dark";

    stylix.autoEnable = false;
    stylix.targets = {
      anki.enable = true;
      fish.enable = true;
      fzf.enable = true;
      ghostty.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      gtksourceview.enable = true;
      # mangohud.enable = true;
      # mpv.enable = true;
      # neovim.enable = true;
      noctalia-shell.enable = true;
      obsidian = {
        enable = true;
        fonts.override.sizes.desktop = 16;
      };
      qt.enable = true;
      zathura.enable = true;
      zen-browser = {
        enable = true;
        profileNames = [ "Default Profile" ];
      };
    };
    ## Niri
    xdg.configFile = {
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
      '';
      "nvim/colors/nix.lua".source =
        with config.lib.stylix.colors.withHashtag;
        (pkgs.replaceVars ./dump/.config/nvim/colors/nix.lua {
          base00 = "${base00}";
          base01 = "${base01}";
          base02 = "${base02}";
          base03 = "${base03}";
          base04 = "${base04}";
          base05 = "${base05}";
          base06 = "${base06}";
          base07 = "${base07}";
          base08 = "${base08}";
          base09 = "${base09}";
          base0A = "${base0A}";
          base0B = "${base0B}";
          base0C = "${base0C}";
          base0D = "${base0D}";
          base0E = "${base0E}";
          base0F = "${base0F}";
        });
    };

    ## Extra noctalia-shell
    programs.noctalia-shell.settings.colorSchemes.darkMode = lib.mkForce (
      lib.mkMerge [
        (lib.mkIf (config.stylix.polarity == "light") false)
        (lib.mkIf (config.stylix.polarity == "dark") true)
      ]
    );
  };
}
