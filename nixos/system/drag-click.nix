{
  config,
  lib,
  ...
}:

{
  options = {
    system.drag-click.enable = lib.mkEnableOption "enables really short click times";
  };
  config = lib.mkIf config.system.drag-click.enable {
    ## Enable Drag clicking
    environment.etc."libinput/local-overrides.quirks".text = ''
      [Never Debounce]
      MatchUdevType=mouse
      ModelBouncingKeys=1
    '';
  };
}
