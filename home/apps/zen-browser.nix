{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.zen-browser.homeModules.beta ];
  options = {
    apps.zen-browser.enable = lib.mkEnableOption "enables zen-browser";
  };

  config = lib.mkIf config.apps.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
      # suppressXdgMigrationWarning = true;
      # profiles = {
      #   "Default Profile" = { };
      # };
    };
  };
}
