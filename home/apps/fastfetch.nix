{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.fastfetch.enable = lib.mkEnableOption "enables fastfetch";
  };
  config = lib.mkIf config.apps.fastfetch.enable {
    xdg.configFile."fastfetch".source = ../../dump/.config/fastfetch;
    home.package = [ pkgs.fastfetch ];
  };
}
