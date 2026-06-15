{
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "silver-xcursors-3d-mod";
  version = "1.0";

  sourceRoot = ".";
  src = ./SilverXMod.tar.gz;

  unpackPhase = "
    runHook preUnpack 
    tar -xf $src
    runHook postUnpack
  ";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -r SilverXMod $out/share/icons
    runHook postInstall
  '';

  meta = {
    description = "Glorious cursor pack from ~23 years ago";
    homepage = "https://www.gnome-look.org/p/2348572";
    license = lib.licenses.lgpl21Only;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [
      XIUM
      EZTEBAN
    ];
  };
})
