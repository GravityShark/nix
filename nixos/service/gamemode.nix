{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    service.gamemode.enable = lib.mkEnableOption "enables gamemode";
  };
  config = lib.mkIf config.service.gamemode.enable {
    environment.sessionVariables.GAMEMODERUNEXEC = "nvidia-offload";
    users.users.${config.username}.extraGroups = [ "gamemode" ];

    programs.gamemode = {
      enable = true;
      enableRenice = false;
      settings = {
        general = {
          # renice = 10;
          softrealtime = "auto";
        };

        custom =
          let
            tuned-adm = "${pkgs.tuned}/bin/tuned-adm";
          in
          lib.mkIf config.service.power-management.enable {
            start = "sh -c 'cp /etc/tuned/active_profile /tmp/active_profile && ${tuned-adm} profile throughput-performance'";
            end = "sh -c '${tuned-adm} profile $(cat /tmp/active_profile)'";
          };
      };
    };
  };
}
