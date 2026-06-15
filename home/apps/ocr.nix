{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.ocr.enable = lib.mkEnableOption "enables ocr";
  };
  config =
    let
      ocr =
        with pkgs;
        (writers.writeDashBin "ocr" ''
          text=$(${grim}/bin/grim -g "$(${slurp}/bin/slurp)" - | ${tesseract}/bin/tesseract stdin stdout 2>/dev/null)
          if [ "$text" = "" ]; then
                  return 1
          fi
          ${wl-clipboard}/bin/wl-copy "$text"
          ${notify-desktop}/bin/notify-desktop -a System -i "$text" "Text copied to clipboard" "$text"
        '');
    in
    lib.mkIf config.apps.ocr.enable {
      home.packages = [ ocr ];
      xdg.desktopEntries.ocr = {
        name = "OCR image";
        exec = "${ocr}/bin/ocr";
      };
    };
}
