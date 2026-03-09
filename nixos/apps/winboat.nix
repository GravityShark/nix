{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.winboat.enable = lib.mkEnableOption "enables winboat";
  };
  config = lib.mkIf config.apps.winboat.enable {
    # virtualisation.containers.enable = true;
    virtualisation.podman.enable = true;
    # virtualisation.podman.defaultNetwork.settings.dns_enabled = true;
    # users.users.${config.username}.extraGroups = [ "podman" ];
    environment.systemPackages = with pkgs; [ winboat ];
  };
}
