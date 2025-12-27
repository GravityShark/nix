{ config, lib, ... }:

{
  options = {
    service.disks.enable = lib.mkEnableOption "enables some disk utilities like fstrim and udisks2";
  };

  config = lib.mkIf config.service.disks.enable {

    services.fstrim.enable = true; # ibe strimmin my disks (runs once at boot)
    services.udisks2.enable = true; # allows for usb storage devices to work without root
  };
}
