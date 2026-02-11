{
  config,
  lib,
  ...
}:

{
  options = {
    system.zram.enable = lib.mkEnableOption "enables zram";
  };
  config = lib.mkIf config.system.zram.enable {
    zramSwap = {
      enable = true;
      priority = 100;
      algorithm = "lz4";
    };
  };
}
