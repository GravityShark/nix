{ lib, pkgs, ... }:

{

  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    autologin
    dwl
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    brightnessctl
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
      ExecStart = "${pkgs.autologin}/bin/autologin gravity ${pkgs.dwl}/bin/dwl";
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
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
