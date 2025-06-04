{ config, ... }:

{
  # Syncthing setup
  services.syncthing = {
    enable = true;
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
    };
  };
}
