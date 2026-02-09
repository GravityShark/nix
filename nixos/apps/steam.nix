{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.steam.enable = lib.mkEnableOption "enables steam";
  };
  config = lib.mkIf config.apps.steam.enable {

    ## Steam
    ## https://github.com/YaLTeR/niri/issues/1034 steam fix
    programs.steam = {
      enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
}
