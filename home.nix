{
  config,
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
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  # ENABLE IF NOT NIXOS
  # targets.genericLinux.enable = false;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gravity";
  home.homeDirectory = "/home/gravity";

  # Paths
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.scripts"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.authenticator
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.pop-shell
    pkgs.gnomeExtensions.run-or-raise
    pkgs.gnome-frog
    pkgs.iosevka-comfy.comfy
    pkgs.iosevka-comfy.comfy-wide-motion
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.iosevka
    pkgs.nixfmt-rfc-style
    pkgs.sesh
    tex
    pkgs.ungoogled-chromium
    pkgs.vial
    pkgs.webcord
    zen-browser.specific
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".clang-format".source = dump/.clang-format;
    ".config/fastfetch".source = dump/.config/fastfetch;
    ".config/fish/conf.d".source = dump/.config/fish/conf.d;
    ".config/fish/config.fish".source = dump/.config/fish/config.fish;
    ".config/fish/functions".source = dump/.config/fish/functions;
    ".config/foot".source = dump/.config/foot;
    ".config/joshuto".source = dump/.config/joshuto;
    ".config/nvim/after".source = dump/.config/nvim/after;
    ".config/nvim/init.lua".source = dump/.config/nvim/init.lua;
    ".config/nvim/lua".source = dump/.config/nvim/lua;
    ".config/nvim/snippets".source = dump/.config/nvim/snippets;
    ".config/run-or-raise".source = dump/.config/run-or-raise;
    ".config/sesh".source = dump/.config/sesh;
    ".doom.d".source = dump/.doom.d;
    ".gitconfig".source = dump/.gitconfig;
    ".mkshrc".source = dump/.mkshrc;
    ".prettierrc".source = dump/.prettierrc;
    ".ruff.toml".source = dump/.ruff.toml;
    ".scripts".source = dump/.scripts;
    ".stylua.toml".source = dump/.stylua.toml;
    ".tmux.conf".source = dump/.tmux.conf;
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Gnome settings
  dconf.settings = {
    "org/gnome/desktop/session".idle-delay = 300;
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>w" ];
      toggle-maximized = [ "<Super>f" ];
      maximize = [ "" ];
      unmaximize = [ "" ];
      switch-group = [ "" ];
      switch-group-backward = [ "" ];
    };
    "org/gnome/desktop/interface" = {
      enable-hot-corners = true;
      color-scheme = "default";
    };
    "org/gnome/settings-daemon/plugins/power" = {
      power-saver-profile-on-low-battery = true;
      sleep-inactive-battery-type = "suspend";
      sleep-inactive-battery-timeout = 900;
      sleep-inactive-ac-type = "suspend";
      sleep-inactive-ac-timeout = 900;
    };
    "org/gnome/mutter" = {
      edge-tiling = true;
      dynamic-workspaces = true;
      workspaces-only-on-primary = false;
    };
    "org/gnome/mutter/wm/keybindings" = {
      toggle-tiled-right = [ "" ];
      toggle-tiled-left = [ "" ];
    };
    "org/gnome/shell" = {
      # "app-switcher".current-workspace-only = false;
      disable-user-extensions = false;
      # `gnome-extensions list` for a list
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "dash-to-dock@micxgx.gmail.com"
        "light-style@gnome-shell-extensions.gcampax.github.com"
        "pop-shell@system76.com"
        "run-or-raise@edvard.cz"
      ];
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      show-trash = false;
      hot-keys = true;
      shortcut = [ "<Super>grave" ];
      shortcut-text = "<Super>grave";
    };
  };

  # Emacs systemd service
  # systemd.user.services.emacs.Unit = {
  #   After = [ "graphical-session-pre.target" ];
  #   PartOf = [ "graphical-session.target" ];
  # };

  # Syncthing setup
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        phone = {
          allowedNetworks = "192.168.0.0/24";
          id = "U2WXU7A-PJ7IO6X-H6YCEXI-SIBCKKW-M7XAOBK-EW5IIIL-3CGARBS-G2LOJA2";
          introducer = true;
        };
        clear = {
          allowedNetworks = "192.168.0.0/24";
          id = "4L66SSN-RBMZE3X-IOJNHJD-UT26UQV-K4HENC2-GQ3QARP-JHQTKWX-EQZZSA3";
          introducer = true;
        };
      };
      folders = {
        "/home/gravity/Notes" = {
          id = "i2ekx-2lgrg";
          devices = [
            "clear"
            "phone"
          ];
          label = "Notes";
        };
      };
    };
  };

  # programs.bash = {
  #   shellAliases = {
  #     nre = "$EDITOR ~/.nix && nixfmt ~/.nix/*";
  #     nrs = "nix flake update ~/.nix && doas chmod 777 /dev/null && doas nixos-rebuild switch --flake ~/.nix";
  #     hme = "$EDITOR ~/.nix/home.nix && nixfmt ~/.nix/*";
  #     hms = "home-manager switch --flake ~/.nix?submodules=1";
  #     fe = "$EDITOR ~/.nix/flake.nix && nixfmt ~/.nix/*";
  #   };
  # };

  # xdg.desktopEntries.discord = {
  #   name = "Messenger";
  #   exec = "chromium --app=https://messenger.com";
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };
  # These will be explicitly sourced when using a shell provided by
  # Home Manager. If you don't want to manage your shell through Home Manager
  # then you have to manually source 'hm-session-vars.sh' located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/gravity/etc/profile.d/hm-session-vars.sh

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
