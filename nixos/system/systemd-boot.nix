{
  config,
  lib,
  ...
}:

{
  options = {
    system.systemd-boot.enable = lib.mkEnableOption "enables systemd-boot";
  };
  config = lib.mkIf config.system.systemd-boot.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 1;
    };
    time.hardwareClockInLocalTime = false; # allow it to work with windows time tbh

  };
}
