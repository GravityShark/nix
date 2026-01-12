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

    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          softrealtime = "auto";
        };

        custom =
          let
            tuned-adm = "${pkgs.tuned}/bin/tuned-adm";
          in
          lib.mkIf config.service.power-management.enable {
            start = "cp /etc/tuned/active_profile /tmp/active_profile && ${tuned-adm} profile throughput-performance";
            end = "${tuned-adm} profile $(cat /tmp/active_profile)";
          };
      };
    };
  };
}
