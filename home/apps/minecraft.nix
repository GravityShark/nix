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
      (callPackage ./packages/ninjabrainbot.nix { })

      (pkgs.waywall.overrideAttrs (
        finalAttrs: previousAttrs: {
          pname = "waywall";
          version = "0.2025.12.30";

          src = fetchFromGitHub {
            owner = "tesselslate";
            repo = "waywall";
            tag = finalAttrs.version;
            hash = "sha256-idtlOXT3RGjAOMgZ+e5vwZnxd33snc4sIjq0G6TU7HU=";
          };
        }
      ))
      lunar-client

      (prismlauncher.override (previous: {
        jdks = [
          graalvmPackages.graalvm-oracle
          # graalvmPackages.graalvm-oracle_17
          javaPackages.compiler.temurin-bin.jre-17
          javaPackages.compiler.temurin-bin.jre-21
          # javaPackages.compiler.temurin-bin.jre-25
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

          libxkbcommon
          xorg.libX11
          xorg.libxcb
          xorg.libXt
          xorg.libXtst
          xorg.libXi
          xorg.libXext
          xorg.libXinerama
          xorg.libXrender
          xorg.libXfixes
          xorg.libXrandr
          xorg.libXcursor
        ];
        additionalPrograms = [
          jemalloc
          (callPackage ./packages/ninjabrainbot.nix { })
          (pkgs.waywall.overrideAttrs (
            finalAttrs: previousAttrs: {
              version = "0-unstable-2026-01-18";
              src = pkgs.fetchFromGitHub {
                owner = "tesselslate";
                repo = "waywall";
                rev = "d0647b422ca93feb0af9d8f9ffae1d0f247baa06";
                hash = "sha256-R0hclyI5edZRlv2Okqr0M2r0Zdf0k7qWnuX0C1io8fs=";
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
    xdg.configFile."waywall/overlay.png".source = ../../dump/.config/waywall/overlay.png;
    # xdg.configFile."xkb/symbols/mc".source = ../../dump/.config/xkb/symbols/mc;
    # xdg.configFile."java/.java/.userPrefs/ninjabrainbot/prefs.xml".source =
    #   ../../dump/.config/java/.java/.userPrefs/ninjabrainbot/prefs.xml;
  };
}
