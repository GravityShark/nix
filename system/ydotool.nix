{ config, ... }:

{
  programs.ydotool.enable = true;
  users.users.gravity.extraGroups = [ "${config.programs.ydotool.group}" ];
}
