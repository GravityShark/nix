{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.syncthing.enable = lib.mkEnableOption "enables syncthing app. does NOT enable service. provides a script `toggle-syncthing` to toggle syncthing using systemd";
  };

  config = lib.mkIf config.apps.syncthing.enable {
    # Syncthing setup
    home.packages = with pkgs; [
      syncthing
      notify-desktop
      (writers.writeDashBin "toggle-syncthing" ''
        if (systemctl is-active --quiet --user syncthing.service); then 
          systemctl stop --user syncthing.service && notify-desktop -i syncthing -a syncthing 'Stopping Syncthing';
        else
          systemctl start --user syncthing.service && notify-desktop -i syncthing -a syncthing 'Starting Syncthing';
        fi
      '')
    ];
    services.syncthing = {
      enable = false;
      settings = {
        devices = {
          brick2ah = {
            name = "brick2ah";
            allowedNetwork = "192.168.0.0/24";
            id = "3IZGDCS-V2NI56X-ZIY42FE-65AKDGO-FDWGB7R-UT5GBBC-PQIBPTY-CIZIBAP";
          };
          clear = {
            name = "clear";
            allowedNetwork = "192.168.0.0/24";
            id = "4L66SSN-RBMZE3X-IOJNHJD-UT26UQV-K4HENC2-GQ3QARP-JHQTKWX-EQZZSA3";
          };
        };
        folders = {
          "/home/${config.home.username}/Notes" = {
            id = "i2ekx-2lgrg";
            devices = [
              "clear"
              "brick2ah"
            ];
            label = "Notes";
            versioning.type = "simple";
          };
        };
        gui = {
          user = config.home.username;
          password = config.home.username;
        };
      };
    };
  };
}
