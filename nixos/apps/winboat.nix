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
    virtualisation.docker.enable = true;
    users.users.${config.username}.extraGroups = [ "docker" ];
    environment.systemPackages = with pkgs; [ winboat ];
  };
}
