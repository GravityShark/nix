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
    # assertions = [
    #   {
    #     assertion = config.apps.fzf.enable;
    #     description = "apps.tmux would not function properly without apps.fzf";
    #   }
    # ];

    home.packages = with pkgs; [
      tmux
      sesh
    ];

    home.file = {
      ".tmux.conf".source = ../../dump/.tmux.conf;
    };

    xdg.configFile = {
      "sesh".source = ../../dump/.config/sesh;
    };
  };
}
