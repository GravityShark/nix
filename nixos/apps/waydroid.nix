{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.waydroid.enable = lib.mkEnableOption "enables waydroid";
  };
  config = lib.mkIf config.apps.waydroid.enable {
    ## WayDroid
    ## waydroid works with either default kernel, or nftables enabled
    ## It is not declarative
    ## https://github.com/casualsnek/waydroid_script
    ## https://wiki.archlinux.org/title/Waydroid
    virtualisation.waydroid.enable = true;
    environment.systemPackages = [ pkgs.waydroid-helper ];
  };
}
