{
  config,
  lib,
  ...
}:

{
  options = {
    apps.fzf.enable = lib.mkEnableOption "enables fzf";
  };
  config = lib.mkIf config.apps.fzf.enable {
    programs.fzf = {
      enable = true;
      enableFishIntegration = config.apps.fish.enable;
      defaultOptions = [
        "--border=none"
        "--layout=reverse"
        "--list-border=rounded"
        "--preview-border=rounded"
        "--height=80%"
      ];
    };
  };
}
