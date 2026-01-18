{
  lib,
  config,
  ...
}:

{
  options = {
    service.power-management.enable = lib.mkEnableOption "enables power-management utilities, like tuned and upower";
  };

  config = lib.mkIf config.service.power-management.enable {
    # services.tlp.enable = true;
    # services.tlp.pd.enable = true;
    services.tuned.enable = true; # power-profiles-daemon, sometimes takes up power randomly
    services.upower.enable = true; # power viewing
  };
}
