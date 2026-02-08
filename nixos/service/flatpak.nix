{
  config,
  lib,
  inputs,
  ...
}:

{
  options = {
    service.flatpak.enable = lib.mkEnableOption "enables flatpak";
  };
  config = lib.mkIf config.service.flatpak.enable {
    imports = [ inputs.flatpaks.nixosModules.nix-flatpak ];

    ## Currently only Roblox works with flatpak
    services.flatpak = {
      enable = true;
      packages = [ "org.vinegarhq.Sober" ];
    };
  };
}
