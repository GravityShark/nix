{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.zen-browser.homeModules.beta ];
  options = {
    apps.zen-browser.enable = lib.mkEnableOption "enables zen-browser";
  };

  config = lib.mkIf config.apps.zen-browser.enable (
    let
      taskbartabs = [
        {
          id = "94e6947d-98b5-46c7-a476-282cbc8c69f7";
          scopes = [ { hostname = "https://mail.google.com/chat/u/0"; } ];
          startUrl = "https://excalidraw.com";
          userContextId = 0;
          name = "Excalidraw";
        }
      ];
    in
    {
      programs.zen-browser = {
        enable = true;
      };

      # Source: https://github.com/bitbloxhub/nixos-config/blob/e2d4683c835fec608a2b5553a1addb937e09ed94/modules/firefox/taskbartabs.nix
      home.file.".mozilla/firefox/nix/taskbartabs/taskbartabs.json".text = builtins.toJSON {
        version = 1;
        taskbarTabs = taskbartabs;
      };

      xdg.desktopEntries = builtins.listToAttrs (
        map (entry: {
          name = "Excalidraw";
          value = {
            type = "Application";
            inherit (entry) name;
            exec = " ${
               inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
             }/bin/zen-beta -taskbar-tab ${entry.id} -new-window ${entry.startUrl}";
          };
        }) taskbartabs
      );
    }
  );
}
