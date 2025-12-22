{ pkgs, ... }:

{
  home.packages = [ pkgs.wayidle ];

  systemd.user.services.wayidle = {
    Unit = {
      Description = "wayidle";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = ''
        ${pkgs.wayidle}/bin/wayidle \
              -t5 ${pkgs.niri}/bin/niri msg action power-off-monitors \
              -t8 ${pkgs.niri}/bin/niri msg action power-on-monitors
      '';
      Restart = "always";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
}
