{ lib, ... }:

{

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".clang-format".source = ../dump/.clang-format;
    # its better to just manually edit the file
    ".gitconfig".source = ../dump/.gitconfig;
    ".mkshrc".source = ../dump/.mkshrc;
    ".prettierrc".source = ../dump/.prettierrc;
    ".ruff.toml".source = ../dump/.ruff.toml;
    ".scripts".source = ../dump/.scripts;
    ".stylua.toml".source = ../dump/.stylua.toml;
    ".tmux.conf".source = ../dump/.tmux.conf;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  xdg.configFile = {
    "fastfetch".source = ../dump/.config/fastfetch;
    "fish/completions".source = ../dump/.config/fish/completions;
    "fish/conf.d".source = ../dump/.config/fish/conf.d;
    "fish/config.fish".source = lib.mkForce ../dump/.config/fish/config.fish;
    "fish/functions".source = ../dump/.config/fish/functions;
    "niri/config.kdl".source = ../dump/.config/niri/config.kdl;
    "sesh".source = ../dump/.config/sesh;
    # "xdg-terminals.list".source = ../dump/.config/xdg-terminals.list;
  };

  # home.sessionPath = [
  #   "${home.homeDirectory}/.scripts"
  #   "${home.homeDirectory}/.scripts/aliases"
  # ];
}
