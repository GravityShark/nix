{ inputs, pkgs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  services.swayidle =
    let
      noctalia-shell = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      lock = "${noctalia-shell}/bin/noctalia-shell ipc call lockScreen lock";
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
          command = lock;
        }
        {
          timeout = 300;
          command = "${pkgs.systemd}/bin/systemctl suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = lock;
        }
        {
          event = "after-resume";
          command = bres;
        }
      ];
    };

}
