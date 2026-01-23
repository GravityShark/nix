{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    system.adb.enable = lib.mkEnableOption "enables adb";
  };
  config = lib.mkIf config.system.adb.enable {
    users.users.${config.username}.extraGroups = [ "adbusers" ];
    environment.systemPackages = with pkgs; [
      android-file-transfer
      android-tools
    ];
  };
}
