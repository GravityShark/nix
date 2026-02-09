{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    apps.atk.enable = lib.mkEnableOption "enables udev rule for atk hub";
  };
  config = lib.mkIf config.apps.atk.enable {
    # ATK udev rule
    # https://old.reddit.com/r/linux_gaming/comments/1feizmm/atk_hub_not_working/lqhja85/
    services.udev.extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f65c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';
  };
}
