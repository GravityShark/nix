{ config, lib, ... }:

{
  options = {
    service.gamemode.enable = lib.mkEnableOption "enables gamemode";
  };
  config = lib.mkIf config.service.gamemode.enable {
    users.users.${config.username}.extraGroups = [ "gamemode" ];

    programs.gamemode = {
      enable = true;
      #   enableRenice = false;
      #   settings = {
      #     general = {
      #       renice = 10;
      #       softrealtime = "auto";
      #     };
      #   };
    };

    # environment.sessionVariables.GAMEMODERUNEXEC = "nvidia-offload";
  };
}
