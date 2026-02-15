{
  config,
  lib,
  ...
}:

{
  options = {
    system.zram.enable = lib.mkEnableOption "enables zram and disables physical swap";
  };
  config = lib.mkIf config.system.zram.enable {
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "lz4";
    };
    # swapDevices = lib.mkForce [ ];
  };
}
