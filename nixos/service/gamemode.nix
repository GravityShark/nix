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
    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };

        custom = {
          start = "${pkgs.notify-desktop}/bin/notify-desktop 'GameMode started'";
          end = "${pkgs.notify-desktop}/bin/notify-desktop 'GameMode ended'";
        };
      };
    };
  };
}
