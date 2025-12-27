{
  lib,
  config,
  ...
}:

{
  options = {
    ydotool.enable = lib.mkEnableOption "enables ydotool";
  };
  config = lib.mkIf config.ydotool.enable {
    programs.ydotool.enable = true;
    users.users.gravity.extraGroups = [ "${config.programs.ydotool.group}" ];
  };
}
