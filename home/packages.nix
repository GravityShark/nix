{
  # config,
  pkgs,
  zen-browser,
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
    # dotnet-sdk
    # pharo
    # R
    # fpc
    # odin
    # zig
    # opam
    # ocamlPackages.ocaml-lsp
    # ocamlPackages.utop
    # ocamlPackages.ocamlformat
    # crystal
    # gleam
    # erlang
    # swift
    # swift-format
    # sourcekit-lsp
    # swiftPackages.swiftpm
    ruby
    # ruby-lsp
    rubyfmt

    ## Mason
    # clang-tools
    # csharp-ls
    # emmet-language-server
    # gofumpt
    # goimports-reviser
    # golangci-lint
    # golines
    # gopls
    # lldb
    gdb
    lua-language-server
    nil
    nixfmt-rfc-style
    # ols
    # perlPackages.PLS
    # prettierd
    # pyright
    # quick-lint-js
    # ruff
    shfmt
    stylua
    # tailwindcss-language-server
    tree-sitter
    # typescript-language-server
    # vscode-langservers-extracted # contains html-lsp and json-lsp
    # zls

    # Apps
    authenticator
    # foliate # because 3.2.1 is brokey
    # fragments # Bittorrent client
    gnome-frog
    ungoogled-chromium
    # vial
    webcord
    zen-browser.default

    # CLIs
    nix-your-shell
    sesh
    tex

    # Fonts
    iosevka-comfy.comfy
    iosevka-comfy.comfy-wide-motion
    nerd-fonts.fira-code
    nerd-fonts.iosevka

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
