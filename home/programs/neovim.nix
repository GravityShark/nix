{
  lib,
  pkgs,
  config,
  ...
}:

{
  xdg.configFile = {
    "nvim/after".source = ../../dump/.config/nvim/after;
    "nvim/relink.go".source = ../../dump/.config/nvim/relink.go;
    "nvim/init.lua".source = ../../dump/.config/nvim/init.lua;
    "nvim/snippets".source = ../../dump/.config/nvim/snippets;
    "nvim/lua/config".source = ../../dump/.config/nvim/lua/config;
    "nvim/lua/pluggers".source = ../../dump/.config/nvim/lua/pluggers;
    "nvim/lua/templates".source = ../../dump/.config/nvim/lua/templates;
  };

  xdg.configFile."nvim/enabled-plugins.txt".text =
    builtins.readFile ../../dump/.config/nvim/enabled-plugins.txt;

  home.activation.relinkPlugins =
    let
      nvim-relink = pkgs.buildGoModule {
        pname = "nvim-relink";
        version = "1";
        src = ../../dump/.config/nvim;
        vendorHash = null;
      };
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${nvim-relink}/bin/relink ${config.xdg.configHome}/nvim
    '';
}
