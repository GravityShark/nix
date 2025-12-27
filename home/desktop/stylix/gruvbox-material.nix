{ pkgs, ... }:

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-medium.yaml";
  stylix.polarity = "light";
  stylix.image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/light/Tranquility.png";
    hash = "sha256-yb+R/lH8OaQcNFIUdY0qlFmsN6sy1GKXhV7LyaQHUe0=";
  };

  xdg.configFile."nvim/enabled-plugins.txt".text = "colors/gruvbox-material";
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
}
