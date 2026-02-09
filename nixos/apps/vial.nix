{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    apps.vial.enable = lib.mkEnableOption "enables vial";
  };
  config = lib.mkIf config.apps.vial.enable {
    # Vial udev rule
    # https://get.vial.today/manual/linux-udev.html
    environment.systemPackages = [ pkgs.vial ];
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f65c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
