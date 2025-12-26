{ lib, config, ... }:

{
  options = {
    printing.enable = lib.mkEnableOption "enables printing";
  };
  config = lib.mkIf config.printing.enable {
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
