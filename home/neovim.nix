{ lib, pkgs, ... }:

{
  xdg.configFile = {
    "nvim/after".source = dump/.config/nvim/after;
    "nvim/enabled-plugins.txt".source = dump/.config/nvim/enabled-plugins.txt;
    "nvim/relink.go".source = dump/.config/nvim/relink.go;
    "nvim/init.lua".source = dump/.config/nvim/init.lua;
    "nvim/snippets".source = dump/.config/nvim/snippets;
    "nvim/lua/config".source = dump/.config/nvim/lua/config;
    "nvim/lua/pluggers".source = dump/.config/nvim/lua/pluggers;
    "nvim/lua/templates".source = dump/.config/nvim/lua/templates;
  };

  home.activation.relinkPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    cd ~/.config/nvim
    ${pkgs.go}/bin/go run relink.go
  '';
}
