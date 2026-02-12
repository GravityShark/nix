{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.desktop.display-server == "niri") {
    programs.niri.enable = true;
    environment.systemPackages = [ pkgs.xwayland-satellite ];
    desktop.command = "${pkgs.niri}/bin/niri-session";
  };
}
