{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    service.cloudflare-warp.enable = lib.mkEnableOption "enables cloudflare-warp";
  };
  config = lib.mkIf config.service.cloudflare-warp.enable {
    services.cloudflare-warp.enable = true;
    environment.systemPackages = [ pkgs.cloudflare-warp ];
  };
}
