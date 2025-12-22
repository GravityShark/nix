{ pkgs, ... }:

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
  stylix.polarity = "dark";
  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/o5/wallhaven-o5zo2l.png";
    hash = "sha256-SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS=";
  };
}
