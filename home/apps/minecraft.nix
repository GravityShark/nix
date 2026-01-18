# Stolen / Inpirations from
# https://github.com/MarwinKreuzig/nixos-config/tree/17864a2c8995f2cb84a2454a27e23f158023ce32/modules/gaming/mcsr
# https://git.uku3lig.net/uku/flake/src/commit/9aa1259d19ae392e0028feaed7b0ce442e6db6d9/programs/mcsr/default.nix
{
  config,
  lib,
  pkgs,
  ...
}:

let
  ninjabrain-bot = pkgs.callPackage ./packages/ninjabrainbot.nix { };
in
{
  options = {
    apps.minecraft = {
      enable = lib.mkEnableOption "enables minecraft";
      #   width = lib.mkOption {
      #     type = lib.types.int;
      #     default = 1920;
      #   };
      #
      #   height = lib.mkOption {
      #     type = lib.types.int;
      #     default = 1080;
      #   };
    };
  };
  config = lib.mkIf config.apps.minecraft.enable {

    # Disable lunar client autostart
    # systemd.user.services."app-lunarclient@autostart".Install.WantedBy = [ ];

    home.packages = with pkgs; [
      # jre
      # lunar-client

      (prismlauncher.override (previous: {
        jdks = [
          graalvmPackages.graalvm-oracle
          # graalvmPackages.graalvm-oracle_17
          # javaPackages.compiler.temurin-bin.jre-17
          # javaPackages.compiler.temurin-bin.jre-21
          # javaPackages.compiler.temurin-bin.jre-25
          # jdk17
          # jdk21
          # jre8
        ];
        additionalLibs = [
          # runtime dependencies necessary for mcsr fairplay mod
          libxtst
          libxkbcommon
          libxt
          libxinerama
        ];
        additionalPrograms = [
          jemalloc
          ninjabrain-bot
          waywall
        ];
      }))
    ];

    programs.obs-studio = {
      enable = true;
      # package = (
      #   pkgs.obs-studio.override {
      #     cudaSupport = true;
      #   }
      # );
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
        input-overlay
      ];
    };

    xdg.configFile."waywall/init.lua".source = pkgs.replaceVars ../../dump/.config/waywall/init.lua {
      eye_overlay = "${../../dump/.config/waywall/overlay.png}";
      ninb_path = "${lib.getExe ninjabrain-bot}";
      # resolution = { w = ${toString config.apps.minecraft.width}, h = ${toString config.apps.minecraft.height} }
    };

    home.file.".java/.userPrefs/ninjabrainbot/prefs.xml".source =
      ../../dump/.java/.userPrefs/ninjabrainbot/prefs.xml;
    # xdg.configFile."waywall/overlay.png".source = ../../dump/.config/waywall/overlay.png;
    # xdg.configFile."xkb/symbols/mc".source = ../../dump/.config/xkb/symbols/mc;
    # xdg.configFile."java/.java/.userPrefs/ninjabrainbot/prefs.xml".source =
    #
  };
}
