{
  lib,
  config,
  pkgs,
  inputs,
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
        # https://github.com/niri-wm/niri/pull/3192 wait for this to get implemented
        bright = "${pkgs.brightnessctl}/bin/brightnessctl";
        bsav = "${bright} --save";
        bset = level: "${bright} set ${level}";
        bres = "${bright} --restore";

        lock = (
          pkgs.writers.writeDashBin "lock" ''
            ${
              inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
            }/bin/noctalia-shell ipc call lockScreen lock;
          ''
        );
      in
      {
        enable = true;
        timeouts = [
          {

            timeout = 1;
            command = (
              if config.desktop.niri.enable then
                "${pkgs.niri}/bin/niri msg action power-off-monitors"
              else
                (bsav + " && " + (bset "0"))
            );
            resumeCommand = (
              if config.desktop.niri.enable then "${pkgs.niri}/bin/niri msg action power-on-monitors" else bres
            );
          }
          {
            timeout = 240;
            command = "${lock}/bin/lock";
          }
          {
            timeout = 300;
            command = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ];
        events = {
          before-sleep = "${lock}/bin/lock";
          after-resume = (
            if config.desktop.niri.enable then "${pkgs.niri}/bin/niri msg action power-on-monitors" else bres
          );
        };
      };

  };
}
