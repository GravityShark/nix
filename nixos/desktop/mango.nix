{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.mangowc.nixosModules.mango ];
  config =
    # autologin
    # https://superuser.com/a/1904473
    let
      autologin_on_7 = pkgs.autologin.overrideAttrs (_: {
        postPatch = ''
          substituteInPlace "main.c" \
            --replace-fail "setup_vt(1);" "setup_vt(7);" \
            --replace-fail "XDG_VTNR=1" "XDG_VTNR=7"
        '';
      });
    in
    lib.mkIf (config.desktop.display-server == "mango") {
      programs.mango.enable = true;

      # In the proposed mangowc.nix
      # xdg.portal = {
      #   extraPortals = with pkgs; [
      #     xdg-desktop-portal-gnome
      #     # xdg-desktop-portal-gtk
      #   ];
      #   config.mango = {
      #     #   common.default = [
      #     #     "gnome"
      #     #     "gtk"
      #     #   ];
      #     "org.freedesktop.impl.portal.Inhibit" = lib.mkForce [ "gtk" ];
      #     "org.freedesktop.impl.portal.Screencast" = [ "gnome" ];
      #     "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      #   };
      # };

      xdg.portal = {
        enable = lib.mkDefault true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-luminous
          xdg-desktop-portal-gtk
        ];
        config.mango = {
          default = [
            "luminous"
            "gtk"
          ];
        };
      };

      # In niri.nix
      # systemd.packages = [
      #   inputs.mangowc.packages.${pkgs.stdenv.hostPlatform.system}.default
      # ];

      # Defined in wayland-session.nix
      programs.dconf.enable = true;
      services.xserver.desktopManager.runXdgAutostartIfNone = true;

      # Use UWSM
      programs.uwsm.enable = true;

      environment.sessionVariables = {
        QT_QPA_PLATFORM = "wayland;xcb";
        # QT_AUTO_SCREEN_SCALE_FACTOR = "1";

        GDK_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";

        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = 1;
      };

      # Using autologin instead of a display manager
      systemd.services.autologin = {
        enable = true;
        restartIfChanged = lib.mkForce false;
        description = "Autologin";
        after = [
          "systemd-user-sessions.service"
          "plymouth-quit-wait.service"
        ];

        serviceConfig = {
          ExecStart = "${autologin_on_7}/bin/autologin ${config.username} ${pkgs.uwsm}/bin/uwsm start mango.desktop";
          Type = "simple";
          IgnoreSIGPIPE = "no";
          SendSIGHUP = "yes";
          TimeoutStopSec = "30s";
          KeyringMode = "shared";
          Restart = "always";
          RestartSec = "1";
        };
        startLimitBurst = 5;
        startLimitIntervalSec = 30;
        aliases = [ "display-manager.service" ];
        wantedBy = [ "multi-user.target" ];
      };

      security.pam.services.autologin = {
        enable = true;
        name = "autologin";
        startSession = true;
        setLoginUid = true;
        updateWtmp = true;
      };
    };
}
