{
  config,
  lib,
  ...
}:

{
  options = {
    system.logind.enable = lib.mkEnableOption "enables logind laptop shit";
  };
  config = lib.mkIf config.system.logind.enable {
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
