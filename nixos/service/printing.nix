{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    service.printing.enable = lib.mkEnableOption "enables printing";
  };
  config = lib.mkIf config.service.printing.enable {
    # https://nixos.wiki/wiki/Printing
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
        brlaser
        brgenml1lpr
        brgenml1cupswrapper
      ];
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    services.ipp-usb.enable = true;
  };
}
