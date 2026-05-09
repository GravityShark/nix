{
  fetchzip,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "hand-of-evil";
  version = "1.2";

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
    description = "Xcursor theme based on Dungeon Keeper II in-game cursors.";
    homepage = "https://github.com/Grief/hand-of-evil";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ Grief ];
  };
})
