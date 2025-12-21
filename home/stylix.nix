{ pkgs, config, ... }:

{
  # https://nix-community.github.io/stylix/configuration.html
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-medium.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/light/Tranquility.png";
    hash = "sha256-yb+R/lH8OaQcNFIUdY0qlFmsN6sy1GKXhV7LyaQHUe0=";
  };
  stylix.fonts = {
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

  stylix.icons.enable = true;
  stylix.icons.package = pkgs.papirus-icon-theme;
  stylix.icons.light = "Papirus-Light";
  stylix.icons.dark = "Papirus-Dark";

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
  };

  # stylix.targets.noctalia-shell.enable = false;
  stylix.targets.kde.enable = false;
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
