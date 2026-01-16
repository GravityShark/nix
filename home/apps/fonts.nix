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
      arkpandora_ttf # Open Arial, Times and Verdana
      inter
      liberation_ttf
      source-sans-pro
    ];

    # Automatic font cache update
    home.activation.updateFontCache =
      let
        after = if (config.desktop.stylix.enable) then "stylixLookAndFeel" else "writeBoundary";
      in
      (lib.hm.dag.entryAfter [ after ] ''${pkgs.fontconfig}/bin/fc-cache -f || echo "fc-cache failed" '');
  };
}
