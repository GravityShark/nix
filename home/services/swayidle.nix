{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    service.swayidle.enable = lib.mkEnableOption "enables swayidle";
  };
  config = lib.mkIf config.service.swayidle.enable {
    assertions = [
      {
        assertion = config.desktop.noctalia.enable;
        message = "sorry bub, for now you need noctalia to lock with swayidle";
      }
    ];

    services.swayidle =
      let
        # https://github.com/YaLTeR/niri/pull/3077 wait for this to get implemented
        # display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors"; -- doesn't work rn
        bright = "${pkgs.brightnessctl}/bin/brightnessctl";
        bsav = "${bright} --save";
        bset = level: "${bright} set ${level}";
        bres = "${bright} --restore";
      in
      {
        enable = true;
        timeouts = [
          {
            timeout = 120;
            command = bsav + " && " + (bset "0");
            resumeCommand = bres;
          }
          # {
          #   timeout = 180;
          #   command = bset "0";
          #   resumeCommand = bres;
          # }
          {
            timeout = 240;
            command = lib.mkIf config.desktop.noctalia.enable "${pkgs.lock}/bin/lock";
          }
          {
            timeout = 300;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = {
          before-sleep.command = lib.mkIf config.desktop.noctalia.enable "${pkgs.lock}/bin/lock";
          after-resume.command = bres;
        };
      };

  };
}
