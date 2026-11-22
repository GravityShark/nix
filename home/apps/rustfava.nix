{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  options = {
    apps.rustfava.enable = lib.mkEnableOption "enables rustfava";
  };
  config = lib.mkIf config.apps.rustfava.enable {
    home.packages = [ inputs.rustfava.packages.${pkgs.stdenv.hostPlatform.system}.desktop ];

    xdg.desktopEntries = {
      rustfava = {
        name = "rustfava";
        genericName = "Ledger";
        comment = "web interface for rustledger";
        icon = "rustfava";
        exec = "rustfava-desktop";
        categories = [
          "Utility"
        ];
      };
    };
  };
}
