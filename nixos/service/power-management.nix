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
    services.tlp = {
      enable = true;
      pd.enable = true;
      settings = {
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "power-saver";
      };
    };
    services.upower.enable = true; # power viewing
  };
}
