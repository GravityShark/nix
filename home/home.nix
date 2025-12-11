{ lib, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gravity";
  home.homeDirectory = "/home/gravity";

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".clang-format".source = dump/.clang-format;
    ".config/fastfetch".source = dump/.config/fastfetch;
    ".config/fish/completions".source = dump/.config/fish/completions;
    ".config/fish/conf.d".source = dump/.config/fish/conf.d;
    ".config/fish/config.fish".source = dump/.config/fish/config.fish;
    ".config/fish/functions".source = dump/.config/fish/functions;
    # ".config/monitors.xml".force = true;
    # ".config/monitors.xml".source = dump/.config/monitors.xml;
    ".config/nvim/after".source = dump/.config/nvim/after;
    ".config/nvim/init.lua".source = dump/.config/nvim/init.lua;
    ".config/nvim/lua".source = dump/.config/nvim/lua;
    ".config/sesh".source = dump/.config/sesh;
    ".config/xdg-terminals.list".source = dump/.config/xdg-terminals.list;
    # its better to just manually edit the file
    ".gitconfig".source = dump/.gitconfig;
    ".mkshrc".source = dump/.mkshrc;
    ".prettierrc".source = dump/.prettierrc;
    ".ruff.toml".source = dump/.ruff.toml;
    ".scripts".source = dump/.scripts;
    ".stylua.toml".source = dump/.stylua.toml;
    ".tmux.conf".source = dump/.tmux.conf;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
}
