# https://git.uku3lig.net/uku/flake/src/branch/main/programs/mcsr/ninjabrain.nix#
{
  lib,
  stdenvNoCC,
  fetchurl,
  libx11,
  libxinerama,
  libxkbcommon,
  libxt,
  copyDesktopItems,
  makeDesktopItem,
  makeWrapper,
  temurin-bin-17,
  java ? temurin-bin-17,
  extraJavaArgs ? [ "-Dawt.useSystemAAFontSettings=on" ],
}:
stdenvNoCC.mkDerivation
  (finalAttrs: {
    pname = "ninjabrain-bot";
    version = "1.5.2";

    src = fetchurl {
      url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/${finalAttrs.version}/Ninjabrain-Bot-${finalAttrs.version}.jar";
      hash = "sha256-mAmfYyGpDUrOwTQA6G0F96+NYOVjnC84Qn6WjccUUP8=";
    };

    desktopItems = [
      (makeDesktopItem {
        name = "ninjabrain-bot";
        type = "Application";
        exec = "ninjabrain-bot";
        comment = "An accurate stronghold calculator for Minecraft speedrunning.";
        desktopName = "Ninjabrain Bot";
        genericName = "A Minecraft stronghold calculator";
        categories = [ "Game" ];
      })
    ];

    nativeBuildInputs = [
      copyDesktopItems
      makeWrapper
    ];

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
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      mainProgram = "ninjabrain-bot";
    };
  })

  stdenvNoCC.mkDerivation
  (finalAttrs: {
    pname = "ninjabrain-bot";
    version = "1.5.2";

    src = fetchurl {
      url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/${finalAttrs.version}/Ninjabrain-Bot-${finalAttrs.version}.jar";
      hash = "sha256-mAmfYyGpDUrOwTQA6G0F96+NYOVjnC84Qn6WjccUUP8=";
    };

    desktopItems = [
      (makeDesktopItem {
        name = "ninjabrain-bot";
        type = "Application";
        exec = "ninjabrain-bot";
        comment = "An accurate stronghold calculator for Minecraft speedrunning.";
        desktopName = "Ninjabrain Bot";
        genericName = "A Minecraft stronghold calculator";
        categories = [ "Game" ];
      })
    ];

    nativeBuildInputs = [
      copyDesktopItems
      makeWrapper
    ];

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
      license = lib.licenses.mit;
      platforms = lib.platforms.linux;
      mainProgram = "ninjabrain-bot";
    };
  })
