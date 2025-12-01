{ pkgs, lib, ... }:

{
  # ENABLE IF NOT NIXOS
  # targets.genericLinux.enable = false;

  imports = [
    ./desktop.nix
    # ./emacs.nix
    ./gnome.nix
    ./keepassxc.nix
    ./mime.nix
    ./packages.nix
    ./restic.nix
    ./syncthing.nix
  ];

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
    ".config/ghostty".source = dump/.config/ghostty;
    # ".config/foot".source = dump/.config/foot;
    # ".config/joshuto".source = dump/.config/joshuto;
    ".config/modprobed-db.conf".source = dump/.config/modprobed-db.conf;
    # ".config/monitors.xml".source = dump/.config/monitors.xml;
    # ".config/monitors.xml".force = true;
    ".config/nvim/after".source = dump/.config/nvim/after;
    ".config/nvim/init.lua".source = dump/.config/nvim/init.lua;
    ".config/nvim/lua".source = dump/.config/nvim/lua;
    ".config/run-or-raise".source = dump/.config/run-or-raise;
    ".config/sesh".source = dump/.config/sesh;
    ".config/xdg-terminals.list".source = dump/.config/xdg-terminals.list;
    # ".config/zoomus.config ".source = dump/.config/zoomus.conf;
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

  # Automatic font cache update
  home.activation.updateFontCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.fontconfig}/bin/fc-cache -f || echo "fc-cache failed, continuing anyway"
  '';

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # auto clean or smthn
  # services.home-manager.autoExpire.enable = true;

  # Auto update
  # services.home-manager.autoUpgrade = {
  #   enable = true;
  #   frequency = "02:00";
  # };
}
