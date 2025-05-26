{ config, ... }:

{
  # Syncthing setup
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        phone = {
          name = "phone";
          allowedNetwork = "192.168.0.0/24";
          id = "U2WXU7A-PJ7IO6X-H6YCEXI-SIBCKKW-M7XAOBK-EW5IIIL-3CGARBS-G2LOJA2";
          introducer = true;
        };
        brick = {
          name = "brick";
          allowedNetwork = "192.168.0.0/24";
          id = "QFP3772-B63OTA4-WXRQQ47-7VWCIDL-4Q6CMI7-ODY6RVA-JBXB5EJ-FXAWFQ5";
          introducer = true;
        };
        clear = {
          name = "clear";
          allowedNetwork = "192.168.0.0/24";
          id = "4L66SSN-RBMZE3X-IOJNHJD-UT26UQV-K4HENC2-GQ3QARP-JHQTKWX-EQZZSA3";
          introducer = true;
        };
      };
      folders = {
        "/home/${config.home.username}/Notes" = {
          id = "i2ekx-2lgrg";
          devices = [
            "clear"
            "phone"
            "brick"
          ];
          label = "Notes";
          versioning.type = "simple";
        };
      };
    };
  };
}
