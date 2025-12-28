{ config, lib, ... }:

{
  options = {
    links.enable = lib.mkEnableOption "enables links";
  };

  config = lib.mkIf config.links.enable {
    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      ".mkshrc".source = ../../dump/.mkshrc;
      ".scripts".source = ../../dump/.scripts;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    xdg.configFile = {
      "fastfetch".source = ../../dump/.config/fastfetch;
      # "xdg-terminals.list".source = ../dump/.config/xdg-terminals.list;
    };

    # home.sessionPath = [
    #   "${home.homeDirectory}/.scripts"
    #   "${home.homeDirectory}/.scripts/aliases"
    # ];
  };
}
