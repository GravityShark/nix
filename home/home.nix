{ ... }:

{
  # ENABLE IF NOT NIXOS
  # targets.genericLinux.enable = false;

  imports = [
    ./default.nix
    ./packages.nix
    ./gnome.nix
    ./syncthing.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gravity";
  home.homeDirectory = "/home/gravity";

  # Emacs service
  services.emacs.enable = true;

  # Auto update
  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "02:00";
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".clang-format".source = dump/.clang-format;
    ".config/fastfetch".source = dump/.config/fastfetch;
    ".config/fish/conf.d".source = dump/.config/fish/conf.d;
    ".config/fish/config.fish".source = dump/.config/fish/config.fish;
    ".config/fish/functions".source = dump/.config/fish/functions;
    ".config/foot".source = dump/.config/foot;
    ".config/joshuto".source = dump/.config/joshuto;
    ".config/nvim/after".source = dump/.config/nvim/after;
    ".config/nvim/init.lua".source = dump/.config/nvim/init.lua;
    ".config/nvim/lua".source = dump/.config/nvim/lua;
    ".config/nvim/snippets".source = dump/.config/nvim/snippets;
    ".config/run-or-raise".source = dump/.config/run-or-raise;
    ".config/sesh".source = dump/.config/sesh;
    ".doom.d".source = dump/.doom.d;
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
