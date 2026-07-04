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

    xdg.desktopEntries = {
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        comment = "Edit text files";
        icon = "nvim";
        # tryExec = "nvim";
        # exec = "ghostty -e nvim \"%F\"";
        # exec = "tmux new-session \"exec nvim \"%F\" \"";
        exec = "nvim %F";
        terminal = true;
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
        ];
      };
    };

    xdg.configFile."nvim/enabled-plugins.txt".text =
      builtins.readFile ../../dump/.config/nvim/enabled-plugins.txt;

    home.activation.relinkPlugins =
      let
        nvim-relink = pkgs.buildGoModule {
          pname = "nvim-relink";
          version = "0-unstable-2025-12-25";
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
    ];

    home.file = {
      ".clang-format".source = ../../dump/.clang-format;
      ".gitconfig".source = ../../dump/.gitconfig;
      ".prettierrc".source = ../../dump/.prettierrc;
      ".ruff.toml".source = ../../dump/.ruff.toml;
      ".stylua.toml".source = ../../dump/.stylua.toml;
    };

    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
        tree-sitter
        clang
        # gnumake
        # go
        # nodejs
        # python3
        # arduino-ide

        ## C
        clang-tools
        # gdb
        # lldb

        ## Go
        gofumpt
        goimports-reviser
        golangci-lint
        golines
        gopls

        ## Java
        # graalvm-ce
        # javaPackages.compiler.temurin-bin.jre-21
        # javaPackages.compiler.temurin-bin.jre-25

        ## Lua
        lua-language-server
        stylua

        ## Nix
        nixd
        nixfmt

        ## Python
        pyright
        ruff

        ## Shell
        shfmt

        ## Web dev
        emmet-language-server
        prettierd
        quick-lint-js
        tailwindcss-language-server
        typescript-language-server
        vscode-langservers-extracted # contains html-lsp and json-lsp

        kdlfmt

        ## 25 day AOC challenge

        # crystal
        # csharp-ls
        # dotnet-sdk
        # erlang
        # fpc
        # gleam
        # ocamlPackages.ocamlformat
        # ocamlPackages.ocaml-lsp
        # ocamlPackages.utop
        # odin
        # ols
        # opam
        # perlPackages.PLS
        # pharo
        # R
        # ruby
        # rubyfmt
        # ruby-lsp
        # sourcekit-lsp
        # swift
        # swift-format
        # swiftPackages.swiftpm
        # zig
      ];
    };

    home.sessionVariables = {
      EDITOR = "nvim";
      SYSTEMD_EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
