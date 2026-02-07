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
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        TLP_DEFAULT_MODE = "BAL";
        TLP_AUTO_SWITCH = 0;
      };
    };
    services.upower.enable = true; # power viewing
  };
}
