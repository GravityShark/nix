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
    # virtualisation.docker.enable = true;

    virtualisation.docker = {
      # Consider disabling the system wide Docker daemon
      enable = false;

      rootless = {
        enable = true;
        setSocketVariable = true;
        # Optionally customize rootless Docker daemon settings
        daemon.settings = {
          dns = [
            "1.1.1.1"
            "8.8.8.8"
          ];
          registry-mirrors = [ "https://mirror.gcr.io" ];
        };
      };
    };
    # users.users.${config.username}.extraGroups = [ "docker" ];
    # virtualisation.containers.enable = true;
    # virtualisation.podman.enable = true;
    # virtualisation.podman.defaultNetwork.settings.dns_enabled = true;
    # users.users.${config.username}.extraGroups = [ "podman" ];
    environment.systemPackages = with pkgs; [ winboat ];
  };
}
