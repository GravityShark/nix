{ lib, config, ... }:

{
  options = {
    service.printing.enable = lib.mkEnableOption "enables printing";
  };
  config = lib.mkIf config.service.printing.enable {
    users.users.${config.username}.extraGroups = [

      "lp"
      "scanner"
    ];
    # https://nixos.wiki/wiki/Printing
    services.printing.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    hardware.sane.enable = true;
  };
}
