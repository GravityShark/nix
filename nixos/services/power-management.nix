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

    environment.packages = with pkgs; [
      (buildGoModule {
        pname = "ppd-dbus-hook";
        version = "1.0.0";
        src = pkgs.fetchFromGitHub {
          owner = "GravityShark";
          repo = "ppd-dbus-hook";
          rev = "a710fa25384ba1c5a79fae949cd2051f52afabb1";
          hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        };
        vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      })
    ];
  };
}
