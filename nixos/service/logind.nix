{
  config,
  lib,
  ...
}:

{
  options = {
    service.logind.enable = lib.mkEnableOption "enables logind";
  };
  config = lib.mkIf config.service.logind.enable {

  };
}
