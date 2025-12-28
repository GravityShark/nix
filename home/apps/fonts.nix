{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.fonts.enable = lib.mkEnableOption "enables fonts";
  };
  config = lib.mkIf config.apps.fonts.enable {
    home.packages = with pkgs; [
      aporetic
      arkpandora_ttf
      inter
      liberation_ttf
      source-sans-pro
    ];

    # Automatic font cache update
    home.activation.updateFontCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.fontconfig}/bin/fc-cache -f || echo "fc-cache failed"
    '';

  };
}
