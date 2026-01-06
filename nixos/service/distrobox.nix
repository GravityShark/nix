{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    service.distrobox.enable = lib.mkEnableOption "enables distrobox";
  };
  config = lib.mkIf config.service.distrobox.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    environment.systemPackages = [ pkgs.distrobox ];
  };
}
