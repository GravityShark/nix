{ config, lib, ... }:

{
  options = {
    apps.gamemode.enable = lib.mkEnableOption "provides gamemode to your doorstep";
  };
  config = lib.mkIf config.apps.gamemode.enable {
    users.users.${config.username}.extraGroups = [ "gamemode" ];

    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          softrealtime = "auto";
        };
      };
    };

    # environment.sessionVariables.GAMEMODERUNEXEC = "nvidia-offload";
  };
}
