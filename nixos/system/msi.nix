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

    systemd.services.ec_sys_fans = {
      description = "Sets the ec_sys fan curve based on the mcontrollcenter address";
      enable = true;
      serviceConfig = {
        ExecStart =
          let
            # https://github.com/dmitry-s93/MControlCenter/blob/3dc28209cbbee9fffa0400ed82e6bc8aa40883bf/src/operate.cpp#L59-L63
            cpu_speed = 114;
            cpu_temp = 106;
            gpu_speed = 138;
            gpu_temp = 130;
            write =
              addr: value:
              "${pkgs.nbfc-linux}/bin/ec_probe write ${builtins.toString addr} ${builtins.toString value}";
          in
          "${pkgs.writers.writeDash "ec_sys_fans" ''
            ${write cpu_speed 38}
            ${write (cpu_speed + 1) 50}
            ${write (cpu_speed + 2) 69}
            ${write (cpu_speed + 3) 86}
            ${write (cpu_speed + 4) 100}
            ${write (cpu_speed + 5) 130}
            ${write (cpu_speed + 6) 150}
            ${write cpu_temp 40}
            ${write (cpu_temp + 1) 50}
            ${write (cpu_temp + 2) 60}
            ${write (cpu_temp + 3) 70}
            ${write (cpu_temp + 4) 80}
            ${write (cpu_temp + 5) 90}

            ${write gpu_speed 38}
            ${write (gpu_speed + 1) 50}
            ${write (gpu_speed + 2) 69}
            ${write (gpu_speed + 3) 86}
            ${write (gpu_speed + 4) 100}
            ${write (gpu_speed + 5) 130}
            ${write (gpu_speed + 6) 150}
            ${write gpu_temp 40}
            ${write (gpu_temp + 1) 50}
            ${write (gpu_temp + 2) 60}
            ${write (gpu_temp + 3) 70}
            ${write (gpu_temp + 4) 80}
            ${write (gpu_temp + 5) 90}
          ''}";
        Restart = "on-failure";
      };
      wantedBy = [ "multi-user.target" ];
    };

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
      description = "Set /msi-ec/shift_mode depending on power-profiles-daemon";
      enable = true;
      requires = [ "tlp-pd.service" ];
      serviceConfig = {
        ExecStart = ''
          ${inputs.ppd-dbus-hook.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ppd-dbus-hook \
            "/bin/sh -c 'echo eco > /sys/devices/platform/msi-ec/shift_mode'" \
            "/bin/sh -c 'echo comfort > /sys/devices/platform/msi-ec/shift_mode'" \
            "/bin/sh -c 'echo turbo > /sys/devices/platform/msi-ec/shift_mode'"
        '';
        Restart = "on-failure";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
