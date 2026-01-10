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
          graalvmPackages.graalvm-oracle
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
      # (pkgs.callPackage (fetchurl {
      #   url = "https://raw.githubusercontent.com/MarwinKreuzig/nixos-config/refs/heads/main/modules/gaming/mcsr/packages/modcheck/default.nix";
      #   hash = "sha256-oeDTGniAJ+s4nPHoy2wwMkpzCAXjQBTVNXTS7yhiHRc=";
      # }) { })
      # (pkgs.callPackage (fetchurl {
      #   url = "https://raw.githubusercontent.com/MarwinKreuzig/nixos-config/refs/heads/main/modules/gaming/mcsr/packages/ninjabrainbot/default.nix";
      #   hash = "sha256-mpwdLu5aLaDjYV7Dto2Lbpub0Zx6cqhHWbH5MvEGq9k=";
      # }) { })
      # (pkgs.callPackage (fetchurl {
      #   url = "https://raw.githubusercontent.com/MarwinKreuzig/nixos-config/refs/heads/main/modules/gaming/mcsr/packages/lingle/default.nix";
      #   hash = "sha256-FNkb4thr1TqbNXUFithSDqa64UFh4hIKE0mctNMoJ9k=";
      # }) { })
      (pkgs.waywall.overrideAttrs (
        finalAttrs: previousAttrs: {
          version = "0-unstable-2026-01-10";
          src = pkgs.fetchFromGitHub {
            owner = "tesselslate";
            repo = "waywall";
            rev = "4fef570253fbd9e1b1eb2fc77f1487cd34c4b67f";
            hash = "sha256-ZaGJePzeJSpCCMCsbi025RnF4n7R5J0LpHIsY0YgfAU=";
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
    # xdg.configFile."java/.java/.userPrefs/ninjabrainbot/prefs.xml".source =
    #   ../../dump/.config/waywall/ninjabrainbot.xml;
  };
}
