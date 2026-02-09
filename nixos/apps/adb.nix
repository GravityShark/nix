{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    apps.adb.enable = lib.mkEnableOption "enables adb";
  };
  config = lib.mkIf config.apps.adb.enable {
    users.users.${config.username}.extraGroups = [ "adbusers" ];
    environment.systemPackages = with pkgs; [
      android-file-transfer
      android-tools
    ];
  };
}
