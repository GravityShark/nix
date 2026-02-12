{
  config,
  lib,
  pkgs,
  ...
}:

{
  config =
    # autologin https://superuser.com/a/1904473
    lib.mkIf (config.desktop.display-server == "niri") {
      programs.niri.enable = true;
      environment.systemPackages = [ pkgs.xwayland-satellite ];
      config.desktop.command = "${pkgs.niri}/bin/niri-session";
    };
}
