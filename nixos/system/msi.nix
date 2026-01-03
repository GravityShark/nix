{
  lib,
  config,
  pkgs,
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

    environment.systemPackages = with pkgs; [ mcontrolcenter ];

    systemd.services.ppd-dbus-hook =
      let
        ppd-dbus-hook = pkgs.buildGoModule {
          pname = "ppd-dbus-hook";
          version = "1";
          src = pkgs.fetchFromGitHub {
            owner = "GravityShark";
            repo = "ppd-dbus-hook";
            rev = "80c4a6adc3dc87ceabd2d622ec76290d815c3c98";
            hash = "sha256-Hgm3NIfvye6kLdXyoAEtp3sh84WbvmQEnuXdG9SZg/Y=";
          };
          vendorHash = "sha256-Ac63bZlBvCrhS7b8mk7aJdApI8UGtJxnZG35L37roGY=";
        };
      in
      {
        enable = true;
        after = [ "tuned-ppd.service" ];
        partOf = [ "tuned-ppd.service" ];
        requires = [ "tuned-ppd.service" ];
        wantedBy = [ "default.target" ];
        description = "Set /msi-ec/shift_mode depending on power-profiles-daemon";
        serviceConfig = {
          ExecStart = ''
            ${ppd-dbus-hook}/bin/ppd-dbus-hook \
              "sh -c 'tee /sys/devices/platform/msi-ec/shift_mode <<< eco'" \
              "sh -c 'tee /sys/devices/platform/msi-ec/shift_mode <<< comfort'" \
              "sh -c 'tee /sys/devices/platform/msi-ec/shift_mode <<< turbo'"
          '';
          Restart = "always";
        };
      };
  };
}
