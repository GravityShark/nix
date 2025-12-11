{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  wc = "scroll";
  name = "gravity";
in
{
  programs.scroll = {
    enable = true;
    extraSessionCommands = ''
        # Tell QT, GDK and others to use the Wayland backend by default, X11 if not available
        export QT_QPA_PLATFORM="wayland;xcb"
        export GDK_BACKEND="wayland,x11"
        export SDL_VIDEODRIVER=wayland
        export CLUTTER_BACKEND=wayland

        # XDG desktop variables to set scroll as the desktop
        export XDG_CURRENT_DESKTOP=scroll
        export XDG_SESSION_TYPE=wayland
        export XDG_SESSION_DESKTOP=scroll

        # Configure Electron to use Wayland instead of X11
        export ELECTRON_OZONE_PLATFORM_HINT=wayland
        export NIXOS_OZONE_WL=1; # Make chromium run on wayland
        export MOZ_ENABLE_WAYLAND=1

        dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SCROLLSOCK XDG_CURRENT_DESKTOP
        "systemctl --user import-environment {,WAYLAND_}DISPLAY SCROLLSOCK; systemctl --user start scroll-session.target"
        scrollmsg -t subscribe '["shutdown"]' && systemctl --user stop scroll-session.target
      ;
    '';
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    config = {
      common.default = [
        "wlr"
        "gtk"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    greetd
    grim
    htop
    slurp
    # sway
    swaybg
    wiremix
    wl-clipboard
    foot
    wmenu
    autologin
  ];

  # Autologin
  # see https://git.sr.ht/~kennylevinsen/autologin
  # https://superuser.com/questions/1904422/how-can-i-use-autologin-without-a-display-manager-for-nixos-wayland-and-niri
  systemd.services.autologin = {
    enable = true;
    restartIfChanged = lib.mkForce false;
    description = "Autologin";
    after = [
      "systemd-user-sessions.service"
      "plymouth-quit-wait.service"
    ];

    serviceConfig = {
      ExecStart = "${pkgs.autologin}/bin/autologin gravity ${
        inputs.scroll-flake.packages.${pkgs.stdenv.hostPlatform.system}.default
      }";
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

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     terminal.vt = 1;
  #     initial_session = {
  #       command = "${wc}";
  #       user = "gravity";
  #     };
  #
  #     default_session = {
  #       command = "${pkgs.greetd}/bin/agreety --cmd ${wc}";
  #       user = "greeter";
  #     };
  #   };
  # };
}
