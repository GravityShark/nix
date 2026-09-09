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
        profiles."User 1".sync = {
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
          (anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "anki-note-linker";
            version = "0-unstable-2026-8-10";
            src = pkgs.fetchFromGitHub {
              owner = "gugutu";
              repo = "Anki-Note-Linker";
              rev = "958ddef4ec1538326db63f637ac2587187a6ec19";
              hash = "sha256-mEdxvwpva/6q4cYa4Tfv9yxaaU2xa5toaEUcXbrXvbI=";
            };
            sourceRoot = "${finalAttrs.src.name}/src/addon";
          }))
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
            version = "2.9.0";
            src = pkgs.fetchFromGitHub {
              owner = "Yutsuten";
              repo = "anki-lifedrain";
              rev = "0b85b9407b01a15cdf437fba02d37222abf4704a";
              hash = "sha256-p8fDZJkOtLeLymfzpSy+JQ0elDf/ZTqFtxqQKTtKYH0=";
            };
            sourceRoot = "${finalAttrs.src.name}/src";
          }))

          (anki-utils.buildAnkiAddon (finalAttrs: {
            pname = "ankimon";
            version = "0-unstable-2026-9-07";
            src = pkgs.fetchFromGitHub {
              owner = "Unlucky-Life";
              repo = "ankimon";
              rev = "197a86923b2cbfea81d8ab897c56965d92f9c64b";
              hash = "sha256-mEdxvwpva/6q4cYa4Tfv9yxaaU2xa5toaEUcXbrXvbI=";
            };
            sourceRoot = "${finalAttrs.src.name}/src/Ankimon";
          }))
        ];
      };
    };
  };
}
