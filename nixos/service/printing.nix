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
    services.ipp-usb.enable = true;
    # https://wiki.nixos.org/wiki/Scanners
    hardware.sane.enable = true;
    users.users.${config.username}.extraGroups = [
      "lp"
      "scanner"
    ];
    # https://nixos.wiki/wiki/Printing
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        cups-filters
        cups-browsed
      ];
    };
    environment.systemPackages = with pkgs; [
      system-config-printer
      sane-frontends # for `xscanimage`
    ];

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
