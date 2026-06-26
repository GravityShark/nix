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
  ninjabrain-bot = pkgs.callPackage ../packages/ninjabrainbot-legal.nix { };
  graalvm-oracle-21 = pkgs.callPackage ../packages/graalvm-oracle-21.nix { };
in
{
  options = {
    apps.minecraft = {
      enable = lib.mkEnableOption "enables minecraft";
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
          graalvm-oracle-21
          temurin-bin-21
          # for newer versions that i dont play rn, i should probably use lunar for this instead
          # graalvmPackages.graalvm-oracle_25
          # temurin-bin-25
        ];
        additionalLibs = [
          # runtime dependencies necessary for mcsr fairplay mod
          libxinerama
          libxkbcommon
          libxt
          libxtst
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
      oneshot_overlay = "${../../dump/.config/waywall/assets/oneshot-cropped-81x81.png}";
    };
    # xdg.configFile."waywall/clean.lua".source = ../../dump/.config/waywall/clean.lua;
  };
}
