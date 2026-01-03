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
        ppd-dbus-hook = (
          pkgs.buildGoModule {
            pname = "ppd-dbus-hook";
            version = "1.0.0";
            src = pkgs.fetchFromGitHub {
              owner = "GravityShark";
              repo = "ppd-dbus-hook";
              rev = "a710fa25384ba1c5a79fae949cd2051f52afabb1";
              hash = "sha256-tqhIoeP5NfaEdKbMjAGt7oqozfRWuSmkLUWqQKCUWVA=";
            };
            vendorHash = "sha256-NGjZ3eUWMYjsQWuLYumpewPY1weNHycu2wl3jz092Bs=";
          }
        );
      in

      lib.mkIf config.service.power-management.enable {
        enable = true;
        after = [ "tuned-ppd.service" ];
        partOf = [ "tuned-ppd.service" ];
        requires = [ "tuned-ppd.service" ];
        wantedBy = [ "default.target" ];
        description = "Set /msi-ec/shift_mode depending on power-profiles-daemon";
        serviceConfig = {
          ExecStart = ''
            ${ppd-dbus-hook}/bin/ppd-dbus-hook \
              "sh -c \"echo eco > /sys/devices/platform/msi-ec/shift_mode\"" \
              "sh -c \"echo comfort > /sys/devices/platform/msi-ec/shift_mode\"" \
              "sh -c \"echo turbo > /sys/devices/platform/msi-ec/shift_mode\""
          '';
          Restart = "on-failure";
        };
      };
  };
}
