{
  config,
  lib,
  ...
}:

{
  options = {
    zerotierone.enable = lib.mkEnableOption "enables zerotierone";
  };
  config = lib.mkIf config.zerotierone.enable {
    services.zerotierone = {
      enable = true;
      joinNetworks = [
        "9e1948db631d39c0"
      ];
    };

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "zerotierone"
      ];
  };
}
