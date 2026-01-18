{
  config,
  lib,
  pkgs,
  ...
}:

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
      ".stylua.toml".source = ../../dump/.stylua.toml;
    };

    home.sessionVariables = {
      GOPATH = "$HOME/.go";
      GOPROXY = "https://proxy.golang.org";
      GOSUMDB = "sum.golang.org";
      CFLAGS = "-std=c99 -Wall -Werror";
    };

    home.packages = with pkgs; [
      ## Dev
      # clang
      # gnumake
      # go
      # nodejs
      # python3
      # arduino-ide

      # C
      clang-tools
      # gdb
      # lldb

      # Go
      gofumpt
      goimports-reviser
      golangci-lint
      golines
      gopls

      # Java
      # graalvm-ce
      # javaPackages.compiler.temurin-bin.jre-21
      # javaPackages.compiler.temurin-bin.jre-25

      # Lua
      lua-language-server
      stylua

      # Nix
      nil
      nixfmt

      # Python
      pyright
      ruff

      # Shell
      shfmt

      # Web dev
      emmet-language-server
      prettierd
      quick-lint-js
      tailwindcss-language-server
      typescript-language-server
      vscode-langservers-extracted # contains html-lsp and json-lsp

      # 25 day AOC challenge

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
}
