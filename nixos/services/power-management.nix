{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    service.power-management.enable = lib.mkEnableOption "enables power-management utilities, like tuned and upower";
  };

  config = lib.mkIf config.service.power-management.enable {
    services.tuned.enable = true; # power-profiles-daemon, sometimes takes up power randomly
    services.upower.enable = true; # power viewing

    environment.systemPackages = [
      (pkgs.buildGoModule {
        pname = "ppd-dbus-hook";
        version = "1";
        src = pkgs.fetchFromGitHub {
          owner = "GravityShark";
          repo = "ppd-dbus-hook";
          rev = "80c4a6adc3dc87ceabd2d622ec76290d815c3c98";
          hash = "sha256-Hgm3NIfvye6kLdXyoAEtp3sh84WbvmQEnuXdG9SZg/Y=";
        };
        vendorHash = "sha256-Ac63bZlBvCrhS7b8mk7aJdApI8UGtJxnZG35L37roGY=";
      })
    ];
  };
}
