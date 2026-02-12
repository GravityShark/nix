{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [ inputs.mangowc.nixosModules.mango ];
  config = lib.mkIf (config.desktop.display-server == "mango") {
    programs.mango.enable = true;
    programs.ssh.startAgent = true; # gnome and niri use the gnome ssh agent by default

    xdg.portal = lib.mkForce {
      enable = true;
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

    # Defined in wayland-session.nix
    programs.dconf.enable = true;
    # services.xserver.desktopManager.runXdgAutostartIfNone = true;

    # Use UWSM
    programs.uwsm.enable = true;

    # For the login manager
    config.desktop.command = "${pkgs.uwsm}/bin/uwsm start mango.desktop";
  };
}
