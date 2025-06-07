{
  # config,
  pkgs,
  zen-browser,
  # prism-launcher,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        etoolbox
        nopageno
        mlmodern
        metafont
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
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

    ## Mason

    clang-tools
    emmet-language-server
    # gdb
    gofumpt
    goimports-reviser
    golangci-lint
    golines
    gopls
    # graalvm-ce
    # lldb
    lua-language-server
    nil
    nixfmt-rfc-style
    prettierd
    pyright
    quick-lint-js
    ruff
    shfmt
    stylua
    tailwindcss-language-server
    # tree-sitter
    typescript-language-server
    vscode-langservers-extracted # contains html-lsp and json-lsp
    # zls

    # Apps

    # arduino-ide
    # authenticator
    # fragments # Bittorrent client
    gnome-frog
    ungoogled-chromium
    vial
    zen-browser.default

    # CLIs
    nix-your-shell
    sesh
    tex
    tomato-c
    xdg-terminal-exec

    # Fonts
    aporetic
    nerd-fonts.iosevka
    source-sans-pro
    # nerd-fonts.ubuntu-sans

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
}
