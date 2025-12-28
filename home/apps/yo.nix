{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.yo.enable = lib.mkEnableOption "enable whatever";
  };

  config = lib.mk config.apps.yo.enable {
    home.packages = with pkgs; [
      super-productivity
      # teams-for-linux
      vial
      youtube-music

      mcontrolcenter # MSI
      qbittorrent

      ## File viewer
      vlc # Videos + Music
      # zathura # Documents

      ## Media
      # audacity
      # gnome-sound-recorder
      # kdePackages.kdenlive # Video editor (I should enable gpu when using this)
      krita # Drawing

      ## School
      onlyoffice-desktopeditors
      pdfarranger
      # telegram-desktop
      # zoom-us

      ## CLIs
      # bc
      # dash
      efibootmgr
      eza
      fastfetch
      fd
      ffmpeg
      # fish
      # fzf
      ghostscript_headless
      git
      imagemagick
      # neovim
      ripgrep
      tmux
      unzip
      zoxide

      ## Dev
      clang
      gnumake
      go
      # nodejs
      python3

      # Arduino
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

      # appimage-run
      doas-sudo-shim
      nix-your-shell
      sesh
      # tomato-c # find something better
      xdg-terminal-exec

      aporetic
      arkpandora_ttf
      inter
      liberation_ttf
      source-sans-pro

      obs-studio
      prismlauncher
      temurin-jre-bin
      waywall

      bubblewrap
      dwarfs
      fuse-overlayfs
      wineWowPackages.staging
    ];

    # Automatic font cache update
    home.activation.updateFontCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.fontconfig}/bin/fc-cache -f || echo "fc-cache failed"
    '';

    programs = {
      anki.enable = true;
      fish.enable = true;
      fzf.enable = true;
      obsidian = {
        enable = true;
        # vaults.Notes = {
        #   enable = true;
        #   target = "Notes";
        # };
      };
      zathura.enable = true;
    };
  };
}

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
