{ pkgs }:

with pkgs;
[
  # Arduino
  arduino-ide

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

  # Lua
  lua-language-server
  stylua

  # Nix
  nil
  nixfmt-rfc-style

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
]
