{
  lib,
  config,
  ...
}:

{
  options = {
    system.msi.enable = lib.mkEnableOption "enables msi";
  };
  config = lib.mkIf config.system.msi.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.msi-ec ];
    boot.kernelModules = [ "msi-ec" ];
    # Sets the msi stats
    systemd.tmpfiles.rules = [
      "w /sys/devices/platform/msi-ec/webcam - - - - off"
      # "w /sys/devices/platform/msi-ec/shift_mode - - - - eco"
      "w /sys/class/leds/msiacpi::kbd_backlight/brightness - - - - 0"
      "w /sys/class/power_supply/BAT1/charge_control_start_threshold - - - - 70"
      "w /sys/class/power_supply/BAT1/charge_control_end_threshold - - - - 00"
    ];
  };

  services.tuned.profiles = {
    balanced = {
      script = {
        "script" = "$\{i:PROFILE_DIR}/script.sh";
        type = "script";
      };
    };
    throughput-performance = {
      script = {
        "script" = "$\{i:PROFILE_DIR}/script.sh";
        type = "script";
      };
    };
  };
}
