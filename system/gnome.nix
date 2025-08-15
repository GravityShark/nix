{ lib, pkgs, ... }:

{
  # Enables gnome and gdm
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # Remove xterm
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gravity";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.gnupg.agent = {
    pinentryPackage = lib.mkDefault pkgs.pinentry-gnome3;
  };

  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
  ];

  # https://wiki.nixos.org/wiki/GNOME#Excluding_GNOME_Applications
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-logs
    gnome-music
    gnome-software
    gnome-text-editor
    gnome-tour # GNOME Shell detects the .desktop file on first log-in.
    gnome-weather
    seahorse # Passwords and Keys
    # simple-scan
    # snapshot
    # sysprof
    totem # Videos that doesnt even work
  ];

  xdg.terminal-exec.settings = {
    default = [ "ghostty.desktop" ];
  };
}
