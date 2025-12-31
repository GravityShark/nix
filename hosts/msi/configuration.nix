# man `configuration.nix(5)` or `nixos-help`

{ config, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Display server
  desktop.display-server = "niri";

  # System
  system = {
    doas.enable = true;
    intel.enable = true;
    # msi.enable = true;
    nvidia.enable = true;
    openrazer.enable = false;
    systemd-boot.enable = true;
    vial.enable = true;
  };

  # Services
  service = {
    bluetooth.enable = true;
    disks.enable = true;
    kanata.enable = true;
    logind.enable = true;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    wayland-pipewire-idle-inhibit.enable = true;
    zerotierone.enable = true;
  };

  # Scripts tha
  update-scripts.enable = true;

  # `man configuration.nix` or https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";

  boot.extraModulePackages = with config.boot.kernelPackages; [ msi-ec ];
  # boot.kernelModules = [ "msi-ec" ];
  # Sets the msi stats
  # systemd.tmpfiles.rules = [
  #   "w /sys/devices/platform/msi-ec/webcam - - - - off"
  #   "w /sys/devices/platform/msi-ec/shift_mode - - - - eco"
  #   "w /sys/class/leds/msiacpi::kbd_backlight/brightness - - - - 0"
  #   "w /sys/class/power_supply/BAT1/charge_control_start_threshold - - - - 70"
  #   "w /sys/class/power_supply/BAT1/charge_control_end_threshold - - - - 00"
  # ];

}
