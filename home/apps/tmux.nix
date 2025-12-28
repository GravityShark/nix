{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.tmux.enable = lib.mkEnableOption "enables tmux";
  };
  config = lib.mkIf config.apps.tmux.enable {
    assertions = [
      {
        assertion = config.apps.fzf.enable;
        message = "apps.tmux would not function properly without apps.fzf";
      }
    ];

    home.packages = with pkgs; [
      bfs
      sesh
      tmux
      zoxide
    ];

    home.file = {
      ".tmux.conf".source = ../../dump/.tmux.conf;
    };

    xdg.configFile = {
      "sesh".source = ../../dump/.config/sesh;
    };
  };
}
