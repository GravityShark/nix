{
  fetchzip,
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "hand-of-evil";
  version = "1.2";

  srcs = map (
    color:
    (fetchzip {
      url = "https://github.com/Grief/hand-of-evil/releases/download/v${finalAttrs.version}/hand-of-evil.tar.gz";
      name = "hand-of-evil";
      hash = "sha256-K0P6EqlJEPke6IMi2viVDzdzHG4zoRv87u5dL5dMem0=";
    })
  );

  postInstall = ''
    mkdir -p $out/share/icons
    cp -r hand-of-evil $out/share/icons
  '';

  meta = {
    description = "Xcursor theme based on Dungeon Keeper II in-game cursors.";
    homepage = "https://github.com/Grief/hand-of-evil";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ Grief ];
  };
})
