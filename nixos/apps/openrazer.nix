{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    apps.openrazer.enable = lib.mkEnableOption "enables openrazer";
  };
  config = lib.mkIf config.apps.openrazer.enable {
    hardware.openrazer.enable = true;
    environment.systemPackages = with pkgs; [
      openrazer-daemon
      polychromatic
    ];
    users.users.${config.username} = {
      extraGroups = [ "openrazer" ];
    };
  };
}
