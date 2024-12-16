{ ... }:

{
  # Syncthing setup
  services.syncthing = {
    enable = true;
    settings = {
      # devices = {
      #   phone = {
      #     allowedNetworks = "192.168.0.0/24";
      #     id = "U2WXU7A-PJ7IO6X-H6YCEXI-SIBCKKW-M7XAOBK-EW5IIIL-3CGARBS-G2LOJA2";
      #     introducer = true;
      #   };
      #   clear = {
      #     allowedNetworks = "192.168.0.0/24";
      #     id = "4L66SSN-RBMZE3X-IOJNHJD-UT26UQV-K4HENC2-GQ3QARP-JHQTKWX-EQZZSA3";
      #     introducer = true;
      #   };
      # };
      folders = {
        "/home/gravity/Notes" = {
          id = "i2ekx-2lgrg";
          devices = [
            "clear"
            "phone"
          ];
          label = "Notes";
          versioning.type = "simple";
        };
      };
    };
  };
}
