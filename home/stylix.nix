{ pkgs, ... }:

{
  # https://nix-community.github.io/stylix/configuration.html
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-light-hard.yaml";
  stylix.image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/light/Tranquility.png";
    hash = "c9bf91fe51fc39a41c345214758d2a9459ac37ab32d46297855ecbc9a40751ed";
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

}
