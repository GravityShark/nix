{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.obs.enable = lib.mkEnableOption "enables obs";
  };
  config = lib.mkIf config.apps.obs.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [ obs-pipewire-audio-capture ];
    };
  };
}
