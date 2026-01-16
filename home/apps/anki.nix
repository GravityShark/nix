{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.anki.enable = lib.mkEnableOption "enables anki";
  };
  config = lib.mkIf config.apps.anki.enable {
    programs = {
      anki = {
        enable = true;
        hideTopBar = true;
        reduceMotion = true;
        spacebarRatesCard = false;
        sync = {
          autoSync = true;
          syncMedia = true;
          keyFile = "/home/${config.home.username}/Notes/backups/anki/syncKey.txt";
          usernameFile = "/home/${config.home.username}/Notes/backups/anki/syncUser.txt";
        };
        answerKeys = [
          {
            ease = 1;
            key = "x";
          }
          {
            ease = 3;
            key = "c";
          }
        ];
        addons = with pkgs; [
          ankiAddons.review-heatmap

          (anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "ankitty";
            version = "1.1.1";
            src = pkgs.fetchFromGitHub {
              owner = "marvinruder";
              repo = "ankitty";
              rev = "v${finalAttrs.version}";
              sparseCheckout = [ "src/ankitty" ];
              hash = "sha256-ra7kv+4Fh3YvXW5+vylvhvTF+E0kn0Futy1TJ5ygrJw=";
            };
            sourceRoot = "${finalAttrs.src.name}/src/ankitty";
          }))

          # Anki note linker needs file accesss which you need to patch it to make it work
          # (anki-utils.buildAnkiAddon (finalAttrs: {
          #   pname = "anki-note-linker";
          #   version = "0-unstable-2025-9-20";
          #   src = pkgs.fetchFromGitHub {
          #     owner = "gugutu";
          #     repo = "Anki-Note-Linker";
          #     rev = "cfd51d17cfd3b40d21a7670d8c79728c8e8e4488";
          #     hash = "sha256-sB7SoblB8lXxiSftTAK101CdeEmqImpr862BIN/5SAY=";
          #   };
          # }))
          #
          # (anki-utils.buildAnkiAddon (finalAttrs: {
          #   pname = "automatic-note-linker";
          #   version = "0-unstable-2024-9-16";
          #   src = pkgs.fetchFromGitHub {
          #     owner = "rrzhang139";
          #     repo = "automatic_note_linker";
          #     rev = "114ae3593e338a95d6524aa5e3163746b36fbe56";
          #     hash = "sha256-Xy5kZPOqVnLoPK/YzFGNE5iLBJbZ06b1nMUdtkhr27M=";
          #   };
          # }))

          (anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "lifedrain";
            version = "0-unstable-2025-5-5";
            src = pkgs.fetchFromGitHub {
              owner = "Yutsuten";
              repo = "anki-lifedrain";
              rev = "c80d5f2d0aff80324a1ecbec8260efb2b26dbdaf";
              hash = "sha256-AbVw0Yncfl/iC3c2UZPvAFH4n2SlcpEYM2OuEXh7ix8=";
            };
          }))
        ];
      };
    };
  };
}
