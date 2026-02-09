{
  config,
  lib,
  inputs,
  pkgs,
  stdenv,
  ...
}:

{
  imports = [ inputs.mango.nixosModules.mango ];
  config =
    let
      autologin_on_7 = pkgs.autologin.overrideAttrs (_: {
        postPatch = ''
          substituteInPlace "main.c" \
            --replace-fail "setup_vt(1);" "setup_vt(7);" \
            --replace-fail "XDG_VTNR=1" "XDG_VTNR=7"
        '';
      });
    in
    lib.mkIf (config.desktop.display-server == "mango")
      # autologin
      # https://superuser.com/a/1904473
      {
        programs.mango.enable = true;

        environment.systemPackages = [ autologin_on_7 ];

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

        # xdg.portal = {
        #   enable = true;
        #   extraPortals = with pkgs; [
        #     xdg-desktop-portal-gnome
        #     xdg-desktop-portal-gtk
        #   ];
        #   config = {
        #     common.default = [
        #       "gnome"
        #       "gtk"
        #     ];
        #   };
        # };

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
            ExecStart = "${autologin_on_7}/bin/autologin ${config.username} ${
              inputs.mango.packages.${stdenv.hostPlatform.system}.default
            }/bin/mango";
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
