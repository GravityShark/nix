{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.distrobox.enable = lib.mkEnableOption "enables distrobox";
  };
  config = lib.mkIf config.apps.distrobox.enable {
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };

    users.users.${config.username}.extraGroups = [ "podman" ];
    environment.systemPackages = [ pkgs.distrobox ];
  };
}
