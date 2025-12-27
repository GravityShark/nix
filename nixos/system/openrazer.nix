{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    system.openrazer.enable = lib.mkEnableOption "enables openrazer";
  };
  config = lib.mkIf config.system.openrazer.enable {
    hardware.openrazer.enable = true;
    environment.systemPackages = with pkgs; [
      openrazer-daemon
      polychromatic
    ];
    users.users.gravity = {
      extraGroups = [ "openrazer" ];
    };
  };
}
