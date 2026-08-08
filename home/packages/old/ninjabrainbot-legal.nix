# https://git.uku3lig.net/uku/mcsr-nixos/src/commit/d5cc7c32013eb3ab9ff9d7e87c512aa49693000a/pkgs/ninjabrain-bot.nix#
{
  lib,
  stdenvNoCC,
  fetchurl,
  libx11,
  libxinerama,
  libxkbcommon,
  libxt,
  makeWrapper,
  temurin-bin-17,
  java ? temurin-bin-17,
  extraJavaArgs ? [ "-Dawt.useSystemAAFontSettings=on" ],
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ninjabrain-bot";
  version = "1.5.1";

  src = fetchurl {
    url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/${finalAttrs.version}/Ninjabrain-Bot-${finalAttrs.version}.jar";
    hash = "sha256-Rxu9A2EiTr69fLBUImRv+RLC2LmosawIDyDPIaRcrdw=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 $src $out/share/ninjabrain-bot/ninjabrain-bot.jar

    makeWrapper ${lib.getExe java} $out/bin/ninjabrain-bot \
        --add-flags "${lib.escapeShellArgs extraJavaArgs} -jar $out/share/ninjabrain-bot/ninjabrain-bot.jar" \
        --prefix LD_LIBRARY_PATH : ${
          lib.makeLibraryPath [
            libx11
            libxinerama
            libxkbcommon
            libxt
          ]
        }

    runHook postInstall
  '';

  meta = {
    description = "Stronghold calculator for Minecraft speedrunning";
    homepage = "https://github.com/Ninjabrain1/Ninjabrain-Bot";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
    mainProgram = "ninjabrain-bot";
  };
})
