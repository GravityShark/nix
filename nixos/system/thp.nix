{
  config,
  lib,
  ...
}:

{
  options = {
    system.thp.enable = lib.mkEnableOption "enables thp";
  };
  config = lib.mkIf config.system.thp.enable {
    ## Transparent Huge Page for Minecraft performance
    boot.kernelParams = [
      "transparent_hugepage=madvise"
      "transparent_hugepage_shmem=advise"
    ];
  };
}
