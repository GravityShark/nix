{ lib, config, ... }:

{
  options = {
    system.vial.enable = lib.mkEnableOption "enables vial";
  };
  config = lib.mkIf config.system.vial.enable {
    # Vial udev rule
    # https://get.vial.today/manual/linux-udev.html
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';

  };
}
