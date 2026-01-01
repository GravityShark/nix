{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # Import the nixcraft home module
    inputs.nixcraft.homeModules.default
  ];
  options = {
    apps.nixcraft.enable = lib.mkEnableOption "enables nixcraft";
  };

  config = lib.mkIf config.apps.nixcraft.enable {
    home.packages = with pkgs; [
      inputs.nixcraft.packages.${system}.nixcraft-cli
      inputs.nixcraft.packages.${system}.nixcraft-auth
      inputs.nixcraft.packages.${system}.nixcraft-skin
    ];
    nixcraft = {
      /*
        * Options starting with underscore such as _clientSettings are for advanced use case
        * Most instance options (such as java, mod loaders) are generic. There are also client/server specific options
        * Options are mostly inferred to avoid duplication.
          Ex: minecraft versions and mod loader versions are automatically inferred if mrpack is set

        * Instances are placed under ~/.local/share/nixcraft/client/instances/<name> or ~/.local/share/nixcraft/server/instances/<name>

        * Executable to run the instance will be put in path as nixcraft-<server/client>-<name>
        * Ex: nixcraft-client-myclient19
        * See the binEntry option for customization

        * Read files found under submodules for more options
        * Read submodules/genericInstanceModule.nix for generic options
      */

      enable = true;

      server.instances = { };

      client = {
        # Config to share with all instances
        shared = {
          # Symlink screenshots dir from all instances
          files."screenshots".source =
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Pictures";

          # Common account
          account = lib.mkDefault {

            username = "susterinoskanye";
            # uuid = "";
            offline = true;
          };

          useDiscreteGPU = true; # Enabled by default

          # Game is passed to the gpu (set if you have nvidia gpu)
          enableNvidiaOffload = true; # Enabled by default

          envVars = {
            # Fixes bug with nvidia (applied by default)
            __GL_THREADED_OPTIMIZATIONS = "0";
            # GDK_BACKEND = "x11";
          };

          binEntry.enable = true;
        };

        instances =
          let
            blazing = {
              username = "BlazingSolrFire";
              accessTokenPath = "${config.home.homeDirectory}/.local/share/nixcraft/auth/access_token";
              offline = false;
            };
            optimization = {
              enable = true;
              version = "1.21.11";

              # Add a desktop entry
              desktopEntry = {
                enable = true;
              };

              mrpack = {
                enable = true;
                # file = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/ddF4bxsz/versions/n6OCFedV/Optimization%20NeoSodium-1.21.11-2.7.mrpack";
                #   hash = "sha256-Zlo55Ng0vI9bIcw0UnyNOwqhILOaRBQ2Z6Wql/yw1T8=";
                # };
                file = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/ddF4bxsz/versions/5AV2H86U/Optimization%20Sodium-1.21.11-4.8.mrpack";
                  hash = "sha256-V1Do0ZVtcmzaEYZncwuLFjytXmrhMHx6SZYTbCUhZLo=";
                };

              };
              waywall.enable = true;

              files = {
                "options.txt".method = "copy-init";
                # "config/betterblockentities.json".method = "copy-init";
                # "config/ferritecore.mixin.properties".method = "copy-init";
                # "config/immediatelyfast.json".method = "copy-init";
                # "config/modernfix-mixins.properties".method = "copy-init";
                # "config/moreculling.toml".method = "copy-init";
              };

              files = {
                "mods/modmenu-17.0.0-beta.1.jar".source = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/hGuj7hNc/modmenu-17.0.0-beta.1.jar";
                  hash = "sha256-xJ49ltXfNwuGXXBZ42YAGGUCvhvdelpOP2x9ay3+iTY=";
                };
                "mods/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar".source = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/HzPcczDK/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar";
                  hash = "sha256-G01m8DMr2l3u4IdV5JPC1qxk1k1SheETSqA2BJdcJSE=";
                };
              };

              java = {
                extraArguments = [
                  "-XX:+UseZGC"
                  "-XX:+UseCompactObjectHeaders"
                ];
                package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
                maxMemory = 8000;
              };
            };
          in
          {
            optimization = optimization;

            optimization-blazing = optimization // {
              account = blazing;
            };
          };
      };
    };
  };
}
