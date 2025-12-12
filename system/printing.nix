{ ... }:

{
  # https://nixos.wiki/wiki/Printing
  services.printing.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
