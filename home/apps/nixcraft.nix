# Config showcasing nixcraft's features
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
    nixcraft =
      let
        # Fetch any mrpack which can be used with both servers and clients!
        optimization-12111 = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/ddF4bxsz/versions/a2nRRv3j/Optimization%20Sodium-1.21.11-4.6.mrpack";
          hash = "sha256-/HPHiAzaMchlHx+SRtIcgKhFGHQWecyln3QCMlQlAGY=";
        };
      in
      {

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
            account = {
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

          instances = {
            optimization = {
              enable = true;
              version = "1.21.11";

              # Add a desktop entry
              desktopEntry = {
                enable = true;
              };

              mrpack = {
                enable = true;
                file = optimization-12111;
              };
              waywall.enable = true;

              files = {
                "options.txt".method = "copy-init";
                "config/betterblockentities.json".method = "copy-init";
                "config/ferritecore.mixin.properties".method = "copy-init";
                "config/immediatelyfast.json".method = "copy-init";
                "config/modernfix-mixins.properties".method = "copy-init";
                "config/moreculling.toml".method = "copy-init";
              };

              files = {
                "mods/modmenu-17.0.0-beta.1.jar".source = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/mOgUt4GM/versions/hGuj7hNc/modmenu-17.0.0-beta.1.jar";
                  hash = "sha256-xJ49ltXfNwuGXXBZ42YAGGUCvhvdelpOP2x9ay3+iTY=";
                };
              };

              account = {
                username = "BlazingSolrFire";
                accessTokenPath = "/home/gravity/.local/share/nixcraft/auth/access_token"; # When using full paths you must rebiuld with --impure
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
          };
        };
      };
  };
}
