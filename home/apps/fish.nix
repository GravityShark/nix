{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.fish.enable = lib.mkEnableOption "enables fish";
  };
  config = lib.mkIf config.apps.fish.enable {
    assertions = [
      {
        assertion = config.apps.fzf.enable;
        message = "apps.fish would not function properly without apps.fzf";
      }
    ];

    programs.fish.enable = true;
    home.packages = with pkgs; [
      nix-your-shell
      eza
    ];
  };
}
