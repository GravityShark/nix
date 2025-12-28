{ config, lib, ... }:

{
  options = {
    apps.dev.enable = lib.mkEnableOption "enable dev cli things and formatter/linter configs";
  };

  config = lib.mkIf config.apps.dev.enable {
    home.file = {
      ".clang-format".source = ../../dump/.clang-format;
      ".gitconfig".source = ../../dump/.gitconfig;
      ".prettierrc".source = ../../dump/.prettierrc;
      ".ruff.toml".source = ../../dump/.ruff.toml;
      ".scripts".source = ../../dump/.scripts;
      ".tmux.conf".source = ../../dump/.tmux.conf;
      ".stylua.toml".source = ../../dump/.stylua.toml;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };
  };
}
