{
  config,
  lib,
  ...
}:

{
  options = {
    service.apps.tmux.enable = lib.mkEnableOption "enables tmux";
  };
  config = lib.mkIf config.service.apps.tmux.enable {

  };
}
