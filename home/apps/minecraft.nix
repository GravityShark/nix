{
  config,
  lib,
  pkgs,
  ...
}:

# Copied a bit from here
# https://github.com/MarwinKreuzig/nixos-config/tree/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr
{
  options = {
    apps.minecraft.enable = lib.mkEnableOption "enables minecraft";
  };
  config = lib.mkIf config.apps.minecraft.enable {
    home.packages = with pkgs; [
      # lunar-client
      jdk21

      (prismlauncher.override (previous: {
        jdks = [
          javaPackages.compiler.temurin-bin.jre-17
          # javaPackages.compiler.temurin-bin.jre-25
          graalvmPackages.graalvm-oracle
          # graalvmPackages.graalvm-ce
          jdk21
          jdk17
          jdk8
        ];
        additionalLibs = [
          # runtime dependencies necessary for mcsr fairplay mod
          jemalloc
          openssl
          xorg.libXtst
          xorg.libXt
          xorg.libxcb
          xorg.libXinerama
          libxkbcommon
        ];
        # additionalPrograms = [
        #   (pkgs.waywall.overrideAttrs (
        #     finalAttrs: previousAttrs: {
        #       version = "0-unstable-2026-01-10";
        #       src = pkgs.fetchFromGitHub {
        #         owner = "tesselslate";
        #         repo = "waywall";
        #         rev = "4fef570253fbd9e1b1eb2fc77f1487cd34c4b67f";
        #         hash = "sha256-ZaGJePzeJSpCCMCsbi025RnF4n7R5J0LpHIsY0YgfAU=";
        #       };
        #       nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ gcc15 ];
        #     }
        #   ))
        # ];
      }))
      # https://github.com/MarwinKreuzig/nixos-config/blob/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr/packages/ninjabrainbot/default.nix
      #   (maven.buildMavenPackage rec {
      #     pname = "ninjabrainbot";
      #     version = "1.5.1";
      #     src = pkgs.fetchFromGitHub {
      #       owner = "Ninjabrain1";
      #       repo = "Ninjabrain-Bot";
      #       rev = version;
      #       hash = "sha256-r8TpL3VLf2QHwFS+DdjxgxyuZu167fP6/lN7a8e9opM=";
      #     };
      #     mvnHash = "sha256-zAVPH5a7ut21Ipz5BUY6cnRLT52bM8Yo2r8ClFon1p0";
      #
      #     desktopItems = [
      #       (pkgs.makeDesktopItem {
      #         name = "ninjabrainbot";
      #         type = "Application";
      #         exec = "ninjabrainbot";
      #         comment = "An accurate stronghold calculator for Minecraft speedrunning.";
      #         desktopName = "Ninjabrain Bot";
      #         genericName = "A Minecraft stronghold calculator";
      #         categories = [ "Game" ];
      #       })
      #     ];
      #
      #     mvnDepsParameters = "assembly:single -DskipTests=true";
      #     mvnParameters = "assembly:single -DskipTests=true";
      #
      #     nativeBuildInputs = [
      #       pkgs.copyDesktopItems
      #       pkgs.makeWrapper
      #     ];
      #
      #     installPhase = ''
      #       runHook preInstall
      #
      #       mkdir -p $out/bin $out/share/ninjabrainbot
      #       install -Dm644 target/ninjabrainbot-${version}-jar-with-dependencies.jar $out/share/ninjabrainbot
      #
      #       makeWrapper ${pkgs.jre}/bin/java $out/bin/ninjabrainbot \
      #         --prefix LD_LIBRARY_PATH : "${
      #           pkgs.lib.makeLibraryPath (
      #             with pkgs;
      #             [
      #               libxkbcommon
      #               xorg.libX11
      #               xorg.libXt
      #               xorg.libXtst
      #               xorg.libXinerama
      #               xorg.libxcb
      #             ]
      #           )
      #         }" \
      #         --add-flags "-DSwing.aatext=TRUE -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel -Dawt.useSystemAAFontSettings=on -jar $out/share/ninjabrainbot/ninjabrainbot-${version}-jar-with-dependencies.jar -Djava.util.prefs.userRoot=$HOME/.config/ninjabrainbot"
      #
      #       runHook postInstall
      #     '';
      #   })
    ];

    # programs.obs-studio = {
    #   enable = true;
    #   package = (
    #     pkgs.obs-studio.override {
    #       cudaSupport = true;
    #     }
    #   );
    #   plugins = with pkgs.obs-studio-plugins; [
    #     obs-pipewire-audio-capture
    #     input-overlay
    #   ];
    # };

    # xdg.configFile."waywall/init.lua".source = ../../dump/.config/waywall/init.lua;
    # xdg.configFile."java/.java/.userPrefs/ninjabrainbot/prefs.xml".source =
    #   ../../dump/.config/java/.java/.userPrefs/ninjabrainbot/prefs.xml;
  };
}
