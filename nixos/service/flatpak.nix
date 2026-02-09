{
  config,
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.flatpaks.nixosModules.nix-flatpak ];

  options = {
    service.flatpak.enable = lib.mkEnableOption "enables flatpak";
  };
  config = lib.mkIf config.service.flatpak.enable {

    ## Currently only Roblox works with flatpak
    services.flatpak = {
      enable = true;
      packages = [ "org.vinegarhq.Sober" ];
      update.onActivation = true;
    };

    xdg.portal.enable = true;
  };
}
