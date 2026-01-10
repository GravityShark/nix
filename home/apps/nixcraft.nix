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
      javaPackages.compiler.temurin-bin.jre-21
      # inputs.nixcraft.packages.${stdenv.hostPlatform.system}.nixcraft-cli
      inputs.nixcraft.packages.${stdenv.hostPlatform.system}.nixcraft-auth
      inputs.nixcraft.packages.${stdenv.hostPlatform.system}.nixcraft-skin
      prismlauncher
      lunar-client
      jemalloc
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
            config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Pictures/Screenshots";

          # Default account
          account = lib.mkDefault {
            username = "susterinoskanye";
            offline = true;
          };

          waywall.enable = true;

          # Create a binary
          binEntry.enable = true;

          # Add a desktop entry
          desktopEntry = {
            enable = true;
          };

          # Put all files during activation instead
          placeFilesAtActivation = true;

          # Nvidia Offload (applied by default)
          enableNvidiaOffload = true;
          useDiscreteGPU = true;

          envVars = {
            # Fixes bug with nvidia (applied by default)
            __GL_THREADED_OPTIMIZATIONS = "0";
          };

          java = {
            package = lib.mkDefault pkgs.graalvmPackages.graalvm-oracle;
            extraArguments = lib.mkDefault [
              "-XX:+UnlockExperimentalVMOptions"
              "-XX:+UnlockDiagnosticVMOptions"
              "-XX:+AlwaysPreTouch"
              "-XX:+DisableExplicitGC"
              "-XX:+UseNUMA"
              "-XX:NmethodSweepActivity=1"
              "-XX:ReservedCodeCacheSize=400M"
              "-XX:NonNMethodCodeHeapSize=12M"
              "-XX:ProfiledCodeHeapSize=194M"
              "-XX:NonProfiledCodeHeapSize=194M"
              "-XX:-DontCompileHugeMethods"
              "-XX:MaxNodeLimit=240000"
              "-XX:NodeLimitFudgeFactor=8000"
              "-XX:+UseVectorCmov"
              "-XX:+PerfDisableSharedMem"
              "-XX:+UseFastUnorderedTimeStamps"
              "-XX:+UseCriticalJavaThreadPriority"
              "-XX:ThreadPriorityPolicy=1"
              "-XX:AllocatePrefetchStyle=3"
              "-XX:+UseG1GC"
              "-XX:MaxGCPauseMillis=37"
              "-XX:+PerfDisableSharedMem"
              "-XX:G1HeapRegionSize=16M"
              "-XX:G1NewSizePercent=23"
              "-XX:G1ReservePercent=20"
              "-XX:SurvivorRatio=32"
              "-XX:G1MixedGCCountTarget=3"
              "-XX:G1HeapWastePercent=20"
              "-XX:InitiatingHeapOccupancyPercent=10"
              "-XX:G1RSetUpdatingPauseTimePercent=0"
              "-XX:MaxTenuringThreshold=1"
              "-XX:G1SATBBufferEnqueueingThresholdPercent=30"
              "-XX:G1ConcMarkStepDurationMillis=5.0"
              # "-XX:G1ConcRSHotCardLimit=16"
              # "-XX:G1ConcRefinementServiceIntervalMillis=150"
              "-XX:GCTimeRatio=99"
              "-XX:+UseLargePages"
              "-XX:LargePageSizeInBytes=2m"
            ];
            maxMemory = 10000;
          };
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

              mrpack = {
                enable = true;
                file = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/ddF4bxsz/versions/5AV2H86U/Optimization%20Sodium-1.21.11-4.8.mrpack";
                  hash = "sha256-V1Do0ZVtcmzaEYZncwuLFjytXmrhMHx6SZYTbCUhZLo=";
                };

              };

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
                # "mods/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar".source = pkgs.fetchurl {
                #   url = "https://cdn.modrinth.com/data/TQTTVgYE/versions/HzPcczDK/fabric-carpet-1.21.11-1.4.194%2Bv251223.jar";
                #   hash = "sha256-G01m8DMr2l3u4IdV5JPC1qxk1k1SheETSqA2BJdcJSE=";
                # };
                "mods/tiptapshow-1.6.7%2B1.21.11.jar".source = pkgs.fetchurl {
                  url = "https://cdn.modrinth.com/data/lIQY64qr/versions/vMOQpnf6/tiptapshow-1.6.7%2B1.21.11.jar";
                  hash = "sha256-GpBmgLaKekRxJ0BVi2OSMC3IlU5QmFyOGdKrTQfIo6w=";
                };
              };

              java = {
                extraArguments = [
                  "-XX:+UseZGC"
                  "-XX:+UseCompactObjectHeaders"
                ];
                package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
              };
            };
          in
          {
            optimization = optimization;

            optimization-blazing = optimization // {
              account = blazing;
            };

            ranked = {
              enable = true;
              lwjglVersion = "3.3.3";
              mrpack = {
                enable = true;
                file = pkgs.fetchurl {
                  url = "https://redlime.github.io/MCSRMods/modpacks/v4/MCSRRanked-Linux-1.16.1-All.mrpack";
                  hash = "sha256-/lYIASwBA62TKhLer3jYzZqUD7NUjqjY7GRQk1Hkd5Y=";
                };
              };
              account = blazing;
            };
          };
      };
    };
  };
}
