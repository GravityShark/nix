{
  lib,
  config,
  ...
}:

{
  options = {
    service.ydotool.enable = lib.mkEnableOption "enables ydotool";
  };
  config = lib.mkIf config.service.ydotool.enable {
    programs.ydotool.enable = true;
    users.users.${config.username}.extraGroups = [ "${config.programs.ydotool.group}" ];
  };
}
