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
  ninjabrain-bot = pkgs.callPackage ../packages/ninjabrainbot.nix { };
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
    systemd.user.services."app-lunarclient@autostart".Install.WantedBy = [ ];

    home.packages = with pkgs; [
      jemalloc
      jdk
      lunar-client

      (prismlauncher.override (previous: {
        jdks = [
          graalvmPackages.graalvm-oracle_17
          javaPackages.compiler.temurin-bin.jdk-21
          # javaPackages.compiler.temurin-bin.jdk-25 # for newer versions that i dont play rn, i should probably use lunar for this instead
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

    home.file.".java/.userPrefs/ninjabrainbot/prefs.xml".source =
      ../../dump/.java/.userPrefs/ninjabrainbot/prefs.xml;
    xdg.configFile."waywall/init.lua".source = pkgs.replaceVars ../../dump/.config/waywall/init.lua {
      background = "${../../dump/.config/waywall/assets/background.png}";
      eye_overlay = "${../../dump/.config/waywall/assets/overlay.png}";
      ninb_path = "${lib.getExe ninjabrain-bot}";
      oneshot_overlay = "${../../dump/.config/waywall/assets/oneshot.png}";
      # resolution = { w = ${toString config.apps.minecraft.width}, h = ${toString config.apps.minecraft.height} }
    };
    xdg.configFile."waywall/clean.lua".source = ../../dump/.config/waywall/clean.lua;
  };
}
