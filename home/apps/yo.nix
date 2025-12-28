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

  config = lib.mkIf config.apps.yo.enable {
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
      powertop
      efibootmgr
      eza
      fastfetch
      fd
      bfs
      ffmpeg
      ghostscript_headless
      git
      imagemagick
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
