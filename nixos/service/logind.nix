{
  config,
  lib,
  ...
}:

{
  options = {
    service.logind.enable = lib.mkEnableOption "enables logind laptop shit";
  };
  config = lib.mkIf config.service.logind.enable {
    services.logind.settings.Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };
}
