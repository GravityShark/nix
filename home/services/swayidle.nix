{
  lib,
  config,
  pkgs,
  ...
}:

{
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
          command = bsav + " && " + (bset "10%");
          resumeCommand = bres;
        }
        {
          timeout = 180;
          command = bset "0";
          resumeCommand = bres;
        }
        {
          timeout = 240;
          command = lib.mkIf config.desktop.noctalia.enable "${pkgs.lock}/bin/lock";
        }
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = lib.mkIf config.desktop.noctalia.enable "${pkgs.lock}/bin/lock";
        }
        {
          event = "after-resume";
          command = bres;
        }
      ];
    };

}
