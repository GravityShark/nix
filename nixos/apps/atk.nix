{
  lib,
  config,
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
      KERNEL=="hidraw*", ATTRS{serial}=="373b", MODE="0666", GROUP="users"
    '';
  };
}
