{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    scripts.enable = lib.mkEnableOption "enables my dot scripts that is in $HOME/.scripts";
  };
  config = lib.mkIf config.scripts.enable {
    ## Local scripts that I would prefer to not add to my shell directly
    home.file.".scripts".source = ../../dump/.scripts;
    home.sessionPath = [
      "${config.home.homeDirectory}/.scripts"
      "${config.home.homeDirectory}/.scripts/aliases"
      "${config.home.homeDirectory}/.local/bin"
    ];

    home.packages = with pkgs; [
      ffmpeg
      sesh
      git
    ];
  };
}
