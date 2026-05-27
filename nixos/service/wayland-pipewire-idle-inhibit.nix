{
  config,
  inputs,
  lib,
  ...
}:

{
  imports = [ inputs.wayland-pipewire-idle-inhibit.nixosModules.default ];
  options = {
    service.wayland-pipewire-idle-inhibit.enable = lib.mkEnableOption "enables wayland-pipewire-idle-inhibit";
  };

  config = lib.mkIf config.service.wayland-pipewire-idle-inhibit.enable {
    services.wayland-pipewire-idle-inhibit = {
      enable = true;
      systemdTarget = "graphical-session.target";
      settings = {
        verbosity = "INFO";
        media_minimum_duration = 10;
        idle_inhibitor = "wayland";
        sink_whitelist = [
          { name = "Built-in Audio Analog Stereo"; }
        ];
        # node_blacklist = [
        #   { name = "spotify"; }
        #   { app_name = "Music Player Daemon"; }
        # ];
      };
    };
  };
}
