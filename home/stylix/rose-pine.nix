{
  # config,
  pkgs,
  lib,
  ...
}:

{
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
  stylix.polarity = "dark";
  stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/o5/wallhaven-o5zo2l.png";
    hash = "sha256-U5RPYzUaPafyAr2QBGqGCh8tCNvfl8wH5av3oIUadws=";
  };
  stylix.cursor.name = lib.mkForce "Bibata-Original-Ice";

  xdg.configFile."nvim/enabled-plugins.txt".text = "colors/rose-pine";
  # lib.mkAfter config.xdg.configFile."nvim/enabled-plugins.txt".text + "colors/rose-pine";
}
