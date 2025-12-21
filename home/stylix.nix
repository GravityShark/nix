{ pkgs, ... }:

{
  # https://nix-community.github.io/stylix/configuration.html
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-hard.yaml";
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

  # stylix.targets.noctalia-shell.enable = false;
  stylix.targets.kde.enable = false;
}
