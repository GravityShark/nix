{ pkgs, config, ... }:

{
  # https://nix-community.github.io/stylix/configuration.html
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-medium.yaml";
  # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
  stylix.autoEnable = false;

  stylix.image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/light/Tranquility.png";
    hash = "sha256-yb+R/lH8OaQcNFIUdY0qlFmsN6sy1GKXhV7LyaQHUe0=";
  };

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
    name = "Bibata-Modern-Classic";
    size = 12;
  };

  stylix.icons.enable = true;
  stylix.icons.package = pkgs.papirus-icon-theme;
  stylix.icons.light = "Papirus-Light";
  stylix.icons.dark = "Papirus-Dark";

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
    obsidian.enable = true;
    qt.enable = true;
    zathura.enable = true;
    zen-browser.enable = true;
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
    "nvim/lua/base16.lua".text = with config.lib.stylix.colors.withHashtag; ''
      return {
                        base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
                        base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
                        base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
                        base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
                      }
    '';
  };
  ## Extra noctalia-shell

}

# palette:
#   base00: "#fbf1c7"
#   base01: "#f2e5bc"
#   base02: "#d5c4a1"
#   base03: "#bdae93"
#   base04: "#665c54"
#   base05: "#654735"
#   base06: "#3c3836"
#   base07: "#282828"
#   base08: "#c14a4a"
#   base09: "#c35e0a"
#   base0A: "#b47109"
#   base0B: "#6c782e"
#   base0C: "#4c7a5d"
#   base0D: "#45707a"
#   base0E: "#945e80"
#   base0F: "#e78a4e"
