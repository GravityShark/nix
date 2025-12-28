{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    system.doas.enable = lib.mkEnableOption "enable doas instead of sudo";
  };
  config = lib.mkIf config.system.doas.enable {
    environment.systemPackages = [ pkgs.doas-sudo-shim ];

    # Use doas instead of sudo
    # https://www.reddit.com/r/NixOS/comments/rts8gm/sudo_or_doas/
    security = {
      sudo.enable = false;
      doas = {
        enable = true;
        extraRules = [
          {
            users = [ config.username ];
            keepEnv = true;
            persist = true;
          }
        ];
      };
    };
  };
}
