{
  fetchzip,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "hand-of-evil";
  version = "1.1";

  sourceRoot = ".";
  srcs = fetchzip {
    url = "https://github.com/piraker-grinor/geared-cursor/releases/download/v${finalAttrs.version}/Geared-${finalAttrs.version}.7z";
    name = "Geared";
    hash = "";
  };

  installPhase = ''
    install -dm 0755 $out/share/icons
    cp -r * $out/share/icons
  '';

  meta = {
    description = "Custom pre-rendered 3D cursor for Linux ";
    homepage = "https://github.com/piraker-grinor/geared-cursor";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ piraker-grinor ];
  };
})
