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

    nixcraft =
      let
        # Fetch any mrpack which can be used with both servers and clients!
        optimization-12111 = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/ddF4bxsz/versions/a2nRRv3j/Optimization%20Sodium-1.21.11-4.6.mrpack";
          hash = "sha256-/HPHiAzaMchlHx+SRtIcgKhFGHQWecyln3QCMlQlAGY=";
        };
        simply-optimized-mrpack = pkgs.fetchurl {
          url = "https://cdn.modrinth.com/data/BYfVnHa7/versions/vZZwrcPm/Simply%20Optimized-1.21.1-5.0.mrpack";
          hash = "sha256-n2BxHMmqpOEMsvDqRRYFfamcDCCT4ophUw7QAJQqXmg=";
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
          * Ex: nixcraft-client-myclient
          * See the binEntry option for customization

          * Read files found under submodules for more options
          * Read submodules/genericInstanceModule.nix for generic options
        */

        enable = true;

        server.instances = { };
        # server = {
        #   # Config shared with all instances
        #   shared = {
        #     agreeToEula = true;
        #     serverProperties.online-mode = false;
        #
        #     binEntry.enable = true;
        #   };
        #
        #   instances = {
        #     # Example server with bare fabric loader
        #     smp = {
        #       enable = true;
        #       version = "1.21.1";
        #       fabricLoader = {
        #         enable = true;
        #         version = "0.17.2";
        #       };
        #     };
        #
        #     # Example server with simply-optimized mrpack loaded
        #     simop = {
        #       enable = true;
        #       mrpack = {
        #         enable = true;
        #         file = simply-optimized-mrpack;
        #       };
        #       java.memory = 2000;
        #       serverProperties = {
        #         level-seed = "6969";
        #         online-mode = false;
        #         bug-report-link = null;
        #       };
        #       # servers can be run as systemd user services
        #       # service name is set as nixcraft-server-<name>.service
        #       service = {
        #         enable = true;
        #         autoStart = false;
        #       };
        #     };
        #
        #     # Example paper server
        #     paper-server = {
        #       version = "1.21.1";
        #       enable = true;
        #       paper.enable = true;
        #       java.memory = 2000;
        #       serverProperties.online-mode = false;
        #     };
        #
        #     onepoint5 = {
        #       enable = true;
        #       version = "1.5.1";
        #     };
        #
        #     onepoint8 = {
        #       enable = true;
        #       version = "1.8";
        #     };
        #
        #     onepoint12 = {
        #       version = "1.12.1";
        #       enable = true;
        #       agreeToEula = true;
        #       # Old versions fail to start if server poperties is immutable
        #       # So copy the file instead
        #       files."server.properties".method = lib.mkForce "copy";
        #       binEntry.enable = true;
        #     };
        #
        #     # Example server with quilt loader
        #     quilt-server = {
        #       enable = true;
        #       version = "1.21.1";
        #       quiltLoader = {
        #         enable = true;
        #         version = "0.29.1";
        #       };
        #     };
        #   };
        # };

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
              GDK_BACKEND = "x11";
            };

            binEntry.enable = true;
          };

          instances = {
            # Example instance with simply-optimized mrpack
            simop = {
              enable = true;

              # Add a desktop entry
              desktopEntry = {
                enable = true;
              };
              mrpack = {
                enable = true;
                file = simply-optimized-mrpack;
              };
            };

            optimization = {
              enable = true;
              version = "1.21.11";

              # Add a desktop entry
              desktopEntry = {
                enable = true;
              };
              mrpack = {
                enable = false;
                file = optimization-12111;
              };
              # files = {
              # "options.txt" = {
              #   text = ./options.txt;
              # };
              # };

              waywall.enable = true;

              java = {
                extraArguments = [
                  "-XX:+UseZGC"
                  "-XX:+UseCompactObjectHeaders"
                ];
                package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
                maxMemory = 8000;
              };
            };

            # Example bare bones client
            nomods = {
              enable = true;
              desktopEntry = {
                enable = true;
              };
              mrpack = {
                enable = false;
                file = optimization-12111;
              };
              version = "1.21.11";
              waywall.enable = true;
              java = {
                extraArguments = [
                  "-XX:+UseZGC"
                  "-XX:+UseCompactObjectHeaders"
                ];
                package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
                maxMemory = 8000;
              };
            };

            # Example client whose version is "latest-release"
            # Supports "latest-snapshot" too
            # latest = {
            #   enable = true;
            #   version = "latest-release";
            # };
            #
            # # Audio doesn't seem to work in old versions
            # onepoint5 = {
            #   enable = true;
            #   version = "1.5.1";
            # };
            #
            # onepoint8 = {
            #   enable = true;
            #   version = "1.8";
            # };
            #
            # onepoint12 = {
            #   enable = true;
            #   version = "1.12.1";
            # };
            #
            # # Example client with quilt loader
            # quilt-client = {
            #   enable = true;
            #   version = "1.21.1";
            #   quiltLoader = {
            #     enable = true;
            #     version = "0.29.1";
            #   };
            # };

            # Example client customized for minecraft speedrunning
            # fsg = {
            #   enable = true;
            #
            #   # this advanced option accepts common arguments that are passed to the client
            #   _classSettings = {
            #     fullscreen = true;
            #     # height = 1080;
            #     # width = 1920;
            #     uuid = "2909ee95-d459-40c4-bcbb-65a0cc413110";
            #     username = "loystonlive";
            #   };
            #   # version = "1.16.1"; # need not be set (inferred)
            #
            #   mrpack = {
            #     enable = true;
            #     file = pkgs.fetchurl {
            #       url = "https://cdn.modrinth.com/data/1uJaMUOm/versions/jIrVgBRv/SpeedrunPack-mc1.16.1-v5.3.0.mrpack";
            #       hash = "sha256-uH/fGFrqP2UpyCupyGjzFB87LRldkPkcab3MzjucyPQ=";
            #     };
            #   };
            #
            #   # Set custom world saves
            #   saves = {
            #     "Practice Map" = pkgs.fetchzip {
            #       url = "https://github.com/Dibedy/The-MCSR-Practice-Map/releases/download/1.0.1/MCSR.Practice.v1.0.1.zip";
            #       stripRoot = false;
            #       hash = "sha256-ukedZCk6T+KyWqEtFNP1soAQSFSSzsbJKB3mU3kTbqA=";
            #     };
            #   };
            #
            #   # place custom files
            #   files = {
            #     # mods can also be manually set
            #     "mods/fsg-mod.jar".source = pkgs.fetchurl {
            #       url = "https://cdn.modrinth.com/data/XZOGBIpM/versions/TcTlTNlF/fsg-mod-5.1.0%2BMC1.16.1.jar";
            #       hash = "sha256-gQfbJMsp+QEnuz4T7dC1jEVoGRa5dmK4fXO/Ea/iM+A=";
            #     };
            #
            #     # setting config files
            #     "config/mcsr/standardsettings.json".source = ./standardsettings.json;
            #     "options.txt" = {
            #       source = ./options.txt;
            #     };
            #   };
            #
            #   java = {
            #     extraArguments = [
            #       "-XX:+UseZGC"
            #       "-XX:+AlwaysPreTouch"
            #       "-Dgraal.TuneInlinerExploration=1"
            #       "-XX:NmethodSweepActivity=1"
            #     ];
            #     # override java package. This mrpack needs java 17
            #     package = pkgs.jdk17;
            #     # set memory in MBs
            #     maxMemory = 3500;
            #     minMemory = 3500;
            #   };
            #
            #   # waywall can be enabled
            #   waywall.enable = true;
            #
            #   # Add executable to path
            #   binEntry = {
            #     enable = true;
            #     # Set executable name
            #     name = "fsg";
            #   };
            #
            #   desktopEntry = {
            #     enable = true;
            #     name = "Nixcraft FSG";
            #     extraConfig = {
            #       # TODO: fix icons not working
            #       # icon = "${inputs.self}/assets/minecraft/dirt.svg";
            #       terminal = true;
            #     };
            #   };
            # };

            # ============================================================
            # MCSR Ranked Example - Full featured speedrunning setup
            # ============================================================
            # ranked = {
            #   enable = true;
            #
            #   mrpack = {
            #     enable = true;
            #     file = pkgs.fetchurl {
            #       url = "https://redlime.github.io/MCSRMods/modpacks/v4/MCSRRanked-Linux-1.16.1-All.mrpack";
            #       hash = "sha256-mPerodqNklfLpeNzcJqe5g/wf9mGFwPNl7vApl/RggI=";
            #     };
            #   };
            #
            #   # Override LWJGL version (required for some speedrunning setups)
            #   lwjglVersion = "3.3.3";
            #
            #   # Enable MangoHud overlay for FPS/performance monitoring
            #   mangohud.enable = true;
            #   # mangohud.configFile = ./mangohud.conf;  # Optional custom config
            #
            #   java = {
            #     package = pkgs.jdk17;
            #     maxMemory = 4096;
            #     minMemory = 512;
            #   };
            #
            #   # Waywall with custom command for GPU selection
            #   waywall = {
            #     enable = true;
            #     # Simple path (auto-adds "wrap --")
            #     binaryPath = "/path/to/waywall";
            #     glfwPath = "/path/to/libglfw.so";
            #
            #     # OR full custom command as list (you control everything)
            #     # command = ["env" "DRI_PRIME=renderD128" "/path/to/waywall" "wrap" "--"];
            #   };
            #
            #   # Microsoft account authentication (use nixcraft-auth to login)
            #   account = {
            #     username = "YourUsername";
            #     accessTokenPath = "/home/user/.local/share/nixcraft/auth/access_token";
            #     # Skin auto-applied before each launch
            #     skin = {
            #       file = /path/to/skin.png;
            #       variant = "classic"; # or "slim"
            #     };
            #   };
            #
            #   binEntry = {
            #     enable = true;
            #     name = "ranked";
            #   };
            #
            #   desktopEntry = {
            #     enable = true;
            #     name = "MCSR Ranked";
            #     icon = /path/to/icon.png;
            #   };
            # };

            # ============================================================
            # RSG (Random Seed Glitchless) Example
            # ============================================================
            # rsg = {
            #   enable = true;
            #
            #   mrpack = {
            #     enable = true;
            #     file = pkgs.fetchurl {
            #       url = "https://cdn.modrinth.com/data/1uJaMUOm/versions/jIrVgBRv/SpeedrunPack-mc1.16.1-v5.3.0.mrpack";
            #       hash = "sha256-uH/fGFrqP2UpyCupyGjzFB87LRldkPkcab3MzjucyPQ=";
            #     };
            #   };
            #
            #   # LWJGL 3.3.3 for better performance
            #   lwjglVersion = "3.3.3";
            #
            #   # MangoHud for monitoring
            #   mangohud.enable = true;
            #
            #   # Custom wrapper command (e.g., gamemoderun)
            #   # wrapper = ["gamemoderun"];
            #   # wrapper = "/usr/bin/gamemoderun";  # String form adds "wrap --"
            #
            #   # Custom environment variables
            #   envVars = {
            #     SOME_VAR = "value";
            #   };
            #
            #   # GPU Selection
            #   useDiscreteGPU = true; # Enable discrete GPU (default: true)
            #   # enableDriPrime = true;      # AMD/Intel: sets DRI_PRIME=1
            #   # enableNvidiaOffload = true; # NVIDIA: sets offload env vars
            #
            #   java = {
            #     package = pkgs.graalvmPackages.graalvm-oracle_17;
            #     maxMemory = 14000;
            #     minMemory = 11500;
            #     extraArguments = [
            #       "-XX:+UnlockExperimentalVMOptions"
            #       "-XX:+UseZGC"
            #       "-XX:+AlwaysPreTouch"
            #     ];
            #   };
            #
            #   # Waywall for wall-style resets
            #   waywall = {
            #     enable = true;
            #     binaryPath = "/path/to/waywall";
            #     glfwPath = "/path/to/libglfw.so";
            #     # profile = "my-profile";       # Optional waywall profile
            #     # configDir = /path/to/config;  # Custom config directory
            #     # configText = "lua code here"; # Inline lua config
            #   };
            #
            #   account = {
            #     username = "YourUsername";
            #     accessTokenPath = "/home/user/.local/share/nixcraft/auth/access_token";
            #   };
            #
            #   binEntry = {
            #     enable = true;
            #     name = "rsg";
            #   };
            #
            #   desktopEntry = {
            #     enable = true;
            #     name = "SeedQueue RSG";
            #     icon = /path/to/icon.png;
            #   };
            # };

            # ============================================================
            # Simple client with MangoHud only
            # ============================================================
            # casual = {
            #   enable = true;
            #   version = "1.21.1";
            #
            #   # Just enable MangoHud overlay
            #   mangohud.enable = true;
            #
            #   # Use a wrapper like gamemoderun
            #   wrapper = [ "gamemoderun" ];
            #
            #   binEntry.enable = true;
            # };
          };
        };
      };
  };
}
