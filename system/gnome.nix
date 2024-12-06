{ lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gravity";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

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
    # seahorse # Passwords and Keys
    # simple-scan
    # snapshot
    # sysprof
    totem # Videos that doesnt even work
  ];

  programs.gnupg.agent = {
    pinentryPackage = lib.mkDefault pkgs.pinentry-gnome;
  };
}
