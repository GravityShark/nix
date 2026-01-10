{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.minecraft.enable = lib.mkEnableOption "enables minecraft";
  };
  config = lib.mkIf config.apps.minecraft.enable {
    home.packages = with pkgs; [
      xwayland

      kdePackages.kdenlive

      (pkgs.prismlauncher.override (previous: {
        jdks = [
          javaPackages.compiler.temurin-bin.jre-25
          graalvmPackages.graalvm-oracle_21
          # graal-pkgs.graalvm-ce
          # jdk21
          # jdk17
          # jdk8
        ];
        # runtime dependencies necessary for mcsr fairplay mod
        additionalLibs = [
          openssl
          xorg.libXtst
          xorg.libXt
          xorg.libxcb
          xorg.libXinerama
          libxkbcommon
        ];
      }))
      (pkgs.callPackage (fetchurl {
        url = "https://raw.githubusercontent.com/MarwinKreuzig/nixos-config/refs/heads/main/modules/gaming/mcsr/packages/modcheck/default.nix";
        hash = "sha256-oeDTGniAJ+s4nPHoy2wwMkpzCAXjQBTVNXTS7yhiHRc=";
      }) { })
      (pkgs.callPackage (fetchurl {
        url = "https://raw.githubusercontent.com/MarwinKreuzig/nixos-config/refs/heads/main/modules/gaming/mcsr/packages/ninjabrainbot/default.nix";
        hash = "";
      }) { })
      (pkgs.callPackage (fetchurl {
        url = "https://raw.githubusercontent.com/MarwinKreuzig/nixos-config/refs/heads/main/modules/gaming/mcsr/packages/lingle/default.nix";
        hash = "";
      }) { })
      (pkgs.waywall.overrideAttrs (
        finalAttrs: previousAttrs: {
          version = "0-unstable-2026-01-02";
          src = pkgs.fetchFromGitHub {
            owner = "tesselslate";
            repo = "waywall";
            rev = "2e911de06a66d0b642e8d21c7a32bb8b3d957955";
            hash = "sha256-9gXKyhiX5cdgGPTVGNY+mKUukcg78kDY0uh01pvSIWE=";
          };
        }
      ))
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
    xdg.configFile."waywall/init.lua".source = ../../dump/.config/waywall/init.lua;
    xdg.configFile."java/.java/.userPrefs/ninjabrainbot/prefs.xml".source =
      ../../dump/.config/waywall/ninjabrainbot.xml;
  };
}
