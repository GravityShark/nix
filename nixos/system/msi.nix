{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    system.msi.enable = lib.mkEnableOption "enables msi";
  };
  config = lib.mkIf config.system.msi.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.msi-ec ];
    boot.kernelModules = [
      "msi-ec"
      "ec_sys"
    ];
    boot.kernelParams = [ "ec_sys.write_support=1" ];

    # Sets the msi stats
    systemd.tmpfiles.rules = [
      "w /sys/class/leds/msiacpi::kbd_backlight/brightness - - - - 0"
      "w /sys/class/power_supply/BAT1/charge_control_end_threshold - - - - 60"
      "w /sys/class/power_supply/BAT1/charge_control_start_threshold - - - - 50"
      "w /sys/devices/platform/msi-ec/fan_mode - - - - advanced"
      # "w /sys/devices/platform/msi-ec/shift_mode - - - - eco"
      "w /sys/devices/platform/msi-ec/webcam - - - - off"
    ];

    environment.systemPackages = with pkgs; [ mcontrolcenter ];

    systemd.services.ppd-dbus-hook = lib.mkIf config.service.power-management.enable {
      enable = true;
      after = [
        "tuned-ppd.service"
        "tlp-pd.service"
      ];
      wantedBy = [ "default.target" ];
      description = "Set /msi-ec/shift_mode depending on power-profiles-daemon";
      serviceConfig = {
        ExecStart = ''
          ${inputs.ppd-dbus-hook.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ppd-dbus-hook \
            "/bin/sh -c 'echo eco > /sys/devices/platform/msi-ec/shift_mode'" \
            "/bin/sh -c 'echo comfort > /sys/devices/platform/msi-ec/shift_mode'" \
            "/bin/sh -c 'echo turbo > /sys/devices/platform/msi-ec/shift_mode'"
        '';
        Restart = "on-failure";
      };
    };
  };
}
