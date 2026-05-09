{
  lib,
  stdenvNoCC,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "golden-xcursors-3d-mod";
  version = "1.0";

  sourceRoot = ".";
  src = ./GoldenXMod.tar.gz;

  unpackPhase = "
    runHook preUnpack 
    tar -xf $src
    runHook postUnpack
  ";

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -r GoldenXMod $out/share/icons
    runHook postInstall
  '';

  meta = {
    description = "Found a glorious cursor pack from ~23 years ago, decided to make it good to go on new systems";
    homepage = "https://www.gnome-look.org/p/2348466";
    license = lib.licenses.lgpl21Only;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [
      XIUM
      EZTEBAN
    ];
  };
})
