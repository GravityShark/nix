{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.desktop.login-manager == "greetd") {
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = config.desktop.command;
          user = config.username;
        };
        default_session = {
          command = "${pkgs.greetd}/bin/dlm";
          user = config.username;
        };
      };
    };
  };
}
