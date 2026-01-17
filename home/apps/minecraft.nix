{
  config,
  lib,
  pkgs,
  ...
}:

# How to setup
# 1.

# Copied a bit from here
# https://github.com/MarwinKreuzig/nixos-config/tree/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr
{
  options = {
    apps.minecraft.enable = lib.mkEnableOption "enables minecraft";
  };
  config = lib.mkIf config.apps.minecraft.enable {
    home.packages = with pkgs; [
      jre
      lunar-client
      (callPackage ./packages/ninjabrainbot.nix { })

      (prismlauncher.override (previous: {
        jdks = [
          graalvmPackages.graalvm-oracle
          # graalvmPackages.graalvm-oracle_17
          # javaPackages.compiler.temurin-bin.jre-17
          javaPackages.compiler.temurin-bin.jre-21
          javaPackages.compiler.temurin-bin.jre-25
          # jdk17
          # jdk21
          # jre8
        ];
        additionalLibs = [
          # runtime dependencies necessary for mcsr fairplay mod
          openssl
          xorg.libXtst
          xorg.libXt
          xorg.libxcb
          xorg.libXinerama
          libxkbcommon
        ];
        additionalPrograms = [
          jemalloc
          (pkgs.waywall.overrideAttrs (
            finalAttrs: previousAttrs: {
              version = "0-unstable-2026-01-10";
              src = pkgs.fetchFromGitHub {
                owner = "tesselslate";
                repo = "waywall";
                rev = "4fef570253fbd9e1b1eb2fc77f1487cd34c4b67f";
                hash = "sha256-ZaGJePzeJSpCCMCsbi025RnF4n7R5J0LpHIsY0YgfAU=";
              };
              nativeBuildInputs = previousAttrs.nativeBuildInputs ++ [ gcc15 ];
            }
          ))
        ];
      }))
    ];

    programs.obs-studio = {
      enable = true;
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        input-overlay
      ];
    };

    systemd.user.services."app-lunarclient@autostart".Install.WantedBy = [ ];

    xdg.configFile."waywall/init.lua".source = ../../dump/.config/waywall/init.lua;
    xdg.configFile."waywall/overlay.lua".source = ../../dump/.config/waywall/overlay.png;
    # xdg.configFile."java/.java/.userPrefs/ninjabrainbot/prefs.xml".source =
    #   ../../dump/.config/java/.java/.userPrefs/ninjabrainbot/prefs.xml;
  };
}
