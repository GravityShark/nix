{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    desktop.mango.enable = lib.mkEnableOption "enables mangowc";
  };
  config = lib.mkIf config.desktop.mango.enable {
    assertions = [
      {
        assertion = config.desktop.noctalia.enable;
        message = "desktop.niri currently needs to have desktop.noctalia";
      }
    ];

    home.packages = with pkgs; [
      brightnessctl
      pantheon.pantheon-agent-polkit
      wl-clipboard
      wl-mirror
      # xlsclients
    ];

    xdg.configFile."mango/config.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.homeDirectory}/.nix/dump/.config/mango/config.conf";
  };
}
