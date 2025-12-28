{ config, lib, ... }:

{
  options = {
    service.vicinae.enable = lib.mkEnableOption "enables vicinae server to allow for start startup, and enables the binary for use";
  };
  config = lib.mkIf config.service.vicinae.enable {
    services.vicinae = {
      enable = true;
      settings = {
        closeOnFocusLoss = true;
        considerPreedit = false;
        faviconService = "twenty";
        font = {
          normal = "Aporetic Sans";
          size = 11;
        };
        keybinding = "default";
        keybinds = {
        };
        popToRootOnClose = true;
        rootSearch = {
          searchFiles = true;
        };
        theme = {
          name = "matugen";
        };
        window = {
          csd = false;
          opacity = 1;
          rounding = 10;
        };
      };
    };
  };
}
