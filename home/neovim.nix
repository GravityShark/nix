{ lib, pkgs, ... }:

let
  nvim-relink = pkgs.buildGoModule {
    pname = "nvim-relink";
    version = "0.2.0";
    src = ./dump/.config/nvim;
    vendorHash = "sha256-REPLACE";
  };
in
{

  xdg.configFile = {
    "nvim/after".source = dump/.config/nvim/after;
    "nvim/relink.go".source = dump/.config/nvim/relink.go;
    "nvim/init.lua".source = dump/.config/nvim/init.lua;
    "nvim/snippets".source = dump/.config/nvim/snippets;
    "nvim/lua/config".source = dump/.config/nvim/lua/config;
    "nvim/lua/pluggers".source = dump/.config/nvim/lua/pluggers;
    "nvim/lua/templates".source = dump/.config/nvim/lua/templates;
  };

  xdg.configFile."nvim/enabled-plugins.txt".text = ''
    main/blink
    main/conform
    main/lint
    main/lsp
    main/snacks
    main/treesitter

    editor/guess-indent
    editor/mini.ai
    editor/mini.jump
    editor/mini.pairs
    editor/mini.surround

    extra/fugitive
    extra/gitsigns
    extra/inc-rename
    extra/neogen
    extra/new-file-template
    extra/oil
    extra/trouble
    extra/ts-comments
    extra/undotree
    extra/which-key

    ui/colorizer
    ui/mini.statusline
    ui/noice
    ui/smear-cursor
    ui/todo-comments
  '';

  home.activation.relinkPlugins = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    cd "$XDG_CONFIG_HOME/nvim"
    ${pkgs.nvim-relink}/bin/nvim-relink
  '';
}
