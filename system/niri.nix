{ lib, pkgs, ... }:

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
{
  programs.niri.enable = true;
  security.polkit.enable = true;
  # services.mako.enable = true;
  systemd.user.services."app-com.mitchellh.ghostty".wantedBy = [ "graphical-session.target" ];

  environment.systemPackages = with pkgs; [
    autologin_on_7
    brightnessctl
    fuzzel
    gnome-system-monitor
    grim
    htop
    mako
    slurp
    swaybg
    swayimg
    swaylock
    wev
    wiremix
    wl-clipboard
    xwayland-satellite
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = 1;
  };

  # powermanagement
  # services.tlp.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config = {
      common.default = [
        "gnome"
        "gtk"
      ];
    };
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
      ExecStart = "${autologin_on_7}/bin/autologin gravity ${pkgs.niri}/bin/niri-session";
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
}
