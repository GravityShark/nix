{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.neovim.enable = lib.mkEnableOption "enables neovim, with the crazy relink crap";
  };

  config = lib.mkIf config.apps.neovim.enable {
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

    home.packages = with pkgs; [
      fd # only use is neovim
      ghostscript_headless # only use is making neovim image pdf thumbnails
      imagemagick # making neovim image thumbnails
      ripgrep # neovim
      unzip # if i need to unzip something, maybe from neovim oil?
    ];
    programs.neovim.enable = true;
  };
}
