{ ... }:

{
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
}
