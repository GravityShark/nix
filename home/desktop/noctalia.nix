{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

{
  options = {
    desktop.noctalia.enable = lib.mkEnableOption "enables noctalia";
  };

  imports = [ inputs.noctalia.homeModules.default ];
  config = lib.mkIf config.desktop.noctalia.enable {

    home.packages = with pkgs; [
      notify-desktop
      (writers.writeDashBin "lock" ''
        ${
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/noctalia-shell ipc call lockScreen lock;
      '')
    ];

    # home.file.".cache/noctalia/wallpapers.json" = lib.mkDefault {
    #   text = builtins.toJSON {
    #     defaultWallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/Tranquility.png";
    #     # wallpapers = {
    #     #   "eDP-1" = "${config.home.homeDirectory}/Pictures/Wallpapers/Tranquility.png";
    #     # };
    #   };
    # };

    xdg.configFile."noctalia/plugins.json".text = ''
      {
          "sources": [
              {
                  "enabled": true,
                  "name": "Official Noctalia Plugins",
                  "url": "https://github.com/noctalia-dev/noctalia-plugins"
              }
          ],
          "states": {
              "fancy-audiovisualizer": {
                  "enabled": true
              },
              "launcher-button": {
                  "enabled": true
              }
          },
          "version": 1
      }'';

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      settings = {
        appLauncher = {
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          enableClipPreview = true;
          enableClipboardHistory = true;
          iconMode = "tabler";
          pinnedExecs = [

          ];
          position = "center";
          showCategories = true;
          sortByMostUsed = true;
          terminalCommand = "ghostty -e";
          useApp2Unit = false;
          viewMode = "list";
        };
        audio = {
          cavaFrameRate = 60;
          externalMixer = "pwvucontrol || ghostty -e wiremix";
          mprisBlacklist = [

          ];
          preferredPlayer = "youtube";
          visualizerType = "none";
          volumeOverdrive = true;
          volumeStep = 5;
        };
        bar = {
          backgroundOpacity = lib.mkDefault 1;
          capsuleOpacity = 1;
          density = "compact";
          exclusive = true;
          floating = false;
          marginHorizontal = 0;
          marginVertical = 0.25;
          monitors = [

          ];
          outerCorners = false;
          position = "bottom";
          showCapsule = false;
          showOutline = false;
          useSeparateOpacity = false;
          widgets = {
            center = [
              {
                blacklist = [

                ];
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                id = "Tray";
                pinned = [

                ];
              }
              {
                characterCount = 1;
                colorizeIcons = true;
                enableScrollWheel = false;
                followFocusedScreen = false;
                groupedBorderOpacity = 0;
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "index";
                showApplications = true;
                showLabelsOnlyWhenOccupied = true;
                unfocusedIconsOpacity = 0.6;
              }
            ];
            left = [
              {
                id = "Spacer";
                width = 1;
              }
              {
                colorizeDistroLogo = true;
                colorizeSystemIcon = "none";
                customIconPath = "";
                enableColorization = true;
                icon = "brand-snowflake";
                id = "ControlCenter";
                useDistroLogo = false;
              }
              {
                defaultSettings = {
                };
                id = "plugin:launcher-button";
              }
              {
                id = "Spacer";
                width = 20;
              }
              {
                hideMode = "hidden";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 800;
                scrollingMode = "hover";
                showAlbumArt = true;
                showArtistFirst = false;
                showProgressRing = true;
                showVisualizer = false;
                useFixedWidth = false;
                visualizerType = "wave";
              }
            ];
            right = [
              {
                compactMode = true;
                diskPath = "/";
                id = "SystemMonitor";
                showCpuTemp = true;
                showCpuUsage = false;
                showDiskUsage = true;
                showGpuTemp = false;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                showNetworkStats = false;
                useMonospaceFont = true;
                usePrimaryColor = false;
              }
              {
                id = "Spacer";
                width = 16;
              }
              {
                displayMode = "alwaysShow";
                id = "WiFi";
              }
              {
                id = "Spacer";
                width = 20;
              }
              {
                displayMode = "onhover";
                id = "Volume";
              }
              {
                id = "Spacer";
                width = 12;
              }
              {
                displayMode = "alwaysShow";
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
                warningThreshold = 30;
              }
              {
                id = "Spacer";
                width = 9;
              }
              {
                customFont = "Aporetic Sans Mono";
                formatHorizontal = "ddd dd hh:mm AP";
                formatVertical = "HH mm";
                id = "Clock";
                tooltipFormat = "HH:mm ddd, MMM dd";
                useCustomFont = true;
                usePrimaryColor = false;
              }
            ];
          };
        };
        brightness = {
          brightnessStep = 5;
          enableDdcSupport = false;
          enforceMinimum = true;
        };
        calendar = {
          cards = [
            {
              enabled = false;
              id = "timer-card";
            }
            {
              enabled = true;
              id = "calendar-header-card";
            }
            {
              enabled = true;
              id = "calendar-month-card";
            }
            {
              enabled = false;
              id = "weather-card";
            }
          ];
        };
        colorSchemes = {
          darkMode = true;
          generateTemplatesForPredefined = false;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          matugenSchemeType = "scheme-fruit-salad";
          predefinedScheme = "Noctalia (default)";
          schedulingMode = "off";
          useWallpaperColors = false;
        };
        controlCenter = {
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = true;
              id = "audio-card";
            }
            {
              enabled = true;
              id = "brightness-card";
            }
            {
              enabled = false;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
          position = "close_to_bar_button";
          shortcuts = {
            left = [
              {
                id = "WiFi";
              }
              {
                id = "Bluetooth";
              }
              {
                enableOnStateLogic = true;
                generalTooltipText = "Syncthing";
                icon = "affiliate";
                id = "CustomButton";
                onClicked = "toggle-syncthing";
                stateChecksJson = "[{\"command\":\"systemctl is-active --quiet --user syncthing.service\",\"icon\":\"\"}]";
              }
              {
                id = "KeepAwake";
              }
              {
                enableOnStateLogic = false;
                generalTooltipText = "Camera";
                icon = "camera";
                id = "CustomButton";
                onClicked = "notify-desktop \"yo make this into an actual button that enables and disables camera 🙏\"";
                onMiddleClicked = "";
                onRightClicked = "";
                stateChecksJson = "[]";
              }
            ];
            right = [
              {
                id = "Notifications";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "ScreenRecorder";
              }
              {
                enableOnStateLogic = false;
                generalTooltipText = "Monitor Configuration";
                icon = "user-screen";
                id = "CustomButton";
                onClicked = "wdisplays";
                onMiddleClicked = "";
                onRightClicked = "";
                stateChecksJson = "[]";
              }
              (lib.mkIf config.apps.syncthing.enable {
                id = "WallpaperSelector";
              })
            ];
          };
        };
        desktopWidgets = {
          enabled = true;
          gridSnap = true;
          monitorWidgets = [
            {
              name = "eDP-1";
              widgets = [
                {
                  defaultSettings = {
                    barWidth = 0.6;
                    bloomIntensity = 0.5;
                    ringOpacity = 0.8;
                    rotationSpeed = 0.5;
                    sensitivity = 1.5;
                    showBars = true;
                    showRings = true;
                  };
                  id = "plugin:fancy-audiovisualizer";
                  showBackground = true;
                  x = 20;
                  y = 740;
                }
              ];
            }
          ];
        };
        dock = {
          animationSpeed = 1;
          backgroundOpacity = lib.mkDefault 1;
          colorizeIcons = true;
          deadOpacity = 0.6;
          displayMode = "auto_hide";
          enabled = false;
          floatingRatio = 1;
          inactiveIndicators = true;
          monitors = [

          ];
          onlySameOutput = true;
          pinnedApps = [

          ];
          pinnedStatic = false;
          size = 1;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          animationDisabled = false;
          animationSpeed = 2;
          avatarImage = "/home/${config.home.username}/Notes/assets/gravityshark.png";
          boxRadiusRatio = 1;
          compactLockScreen = false;
          dimmerOpacity = 0.5;
          enableShadows = true;
          forceBlackScreenCorners = false;
          iRadiusRatio = 0.3;
          language = "";
          lockOnSuspend = true;
          radiusRatio = 0.3;
          scaleRatio = 1;
          screenRadiusRatio = 0.3;
          shadowDirection = "center";
          shadowOffsetX = 0;
          shadowOffsetY = 0;
          showHibernateOnLockScreen = true;
          showScreenCorners = false;
          showSessionButtonsOnLockScreen = true;
        };
        hooks = {
          darkModeChange = "";
          enabled = false;
          performanceModeDisabled = "";
          performanceModeEnabled = "";
          screenLock = "";
          screenUnlock = "";
          wallpaperChange = "";
        };
        location = {
          analogClockInCalendar = true;
          firstDayOfWeek = -1;
          name = "Tokyo";
          showCalendarEvents = true;
          showCalendarWeather = true;
          showWeekNumberInCalendar = false;
          use12hourFormat = true;
          useFahrenheit = false;
          weatherEnabled = false;
          weatherShowEffects = true;
        };
        network = {
          wifiEnabled = true;
        };
        nightLight = {
          autoSchedule = true;
          dayTemp = "6500";
          enabled = false;
          forced = false;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          nightTemp = "4000";
        };
        notifications = {
          backgroundOpacity = lib.mkDefault 1;
          criticalUrgencyDuration = 15;
          enableKeyboardLayoutToast = true;
          enabled = true;
          location = "top_right";
          lowUrgencyDuration = 3;
          monitors = [

          ];
          normalUrgencyDuration = 8;
          overlayLayer = true;
          respectExpireTimeout = false;
          saveToHistory = {
            critical = true;
            low = true;
            normal = true;
          };
          sounds = {
            criticalSoundFile = "";
            enabled = true;
            excludedApps = "discord,firefox,chrome,chromium,edge";
            lowSoundFile = "";
            normalSoundFile = "";
            separateSounds = false;
            volume = 0.75;
          };
        };
        osd = {
          autoHideMs = 2000;
          backgroundOpacity = lib.mkDefault 1;
          enabled = true;
          enabledTypes = [
            0
            1
            2
            3
          ];
          location = "top_right";
          monitors = [

          ];
          overlayLayer = true;
        };
        screenRecorder = {
          audioCodec = "opus";
          audioSource = "default_output";
          colorRange = "limited";
          copyToClipboard = false;
          directory = "/home/${config.home.username}/Videos/Screencasts";
          frameRate = 60;
          quality = "very_high";
          showCursor = true;
          videoCodec = "av1";
          videoSource = "portal";
        };
        sessionMenu = {
          countdownDuration = 5000;
          enableCountdown = true;
          largeButtonsStyle = false;
          position = "center";
          powerOptions = [
            {
              action = "lock";
              command = "";
              countdownEnabled = false;
              enabled = true;
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = false;
              enabled = true;
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = false;
            }
          ];
          showHeader = false;
          showNumberLabels = true;
        };
        settingsVersion = 35;
        systemMonitor = {
          cpuCriticalThreshold = 90;
          cpuPollingInterval = 3000;
          cpuWarningThreshold = 80;
          criticalColor = "#cc241d";
          diskCriticalThreshold = 90;
          diskPath = "/";
          diskPollingInterval = 3000;
          diskWarningThreshold = 90;
          enableDgpuMonitoring = false;
          gpuCriticalThreshold = 90;
          gpuPollingInterval = 3000;
          gpuWarningThreshold = 80;
          memCriticalThreshold = 70;
          memPollingInterval = 3000;
          memWarningThreshold = 70;
          networkPollingInterval = 3000;
          tempCriticalThreshold = 60;
          tempPollingInterval = 3000;
          tempWarningThreshold = 60;
          useCustomColors = false;
          warningColor = "#458588";
        };
        templates = {
          alacritty = false;
          cava = false;
          code = false;
          discord = true;
          emacs = false;
          enableUserTemplates = false;
          foot = false;
          fuzzel = false;
          ghostty = false;
          gtk = false;
          helix = false;
          hyprland = false;
          kcolorscheme = false;
          kitty = false;
          mango = false;
          niri = false;
          pywalfox = false;
          qt = false;
          spicetify = false;
          telegram = false;
          vicinae = false;
          walker = false;
          wezterm = false;
          yazi = false;
          zed = false;
        };
        ui = {
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          fontDefault = "Aporetic Sans";
          fontDefaultScale = 1;
          fontFixed = "Aporetic Sans Mono";
          fontFixedScale = 1.25;
          panelBackgroundOpacity = lib.mkDefault 1;
          panelsAttachedToBar = true;
          settingsPanelMode = "centered";
          tooltipsEnabled = true;
          wifiDetailsViewMode = "grid";
        };
        wallpaper = {
          directory = "/home/${config.home.username}/Pictures/Wallpapers";
          enableMultiMonitorDirectories = false;
          enabled = true;
          fillColor = "#000000";
          fillMode = "crop";
          hideWallpaperFilenames = true;
          monitorDirectories = [

          ];
          overviewEnabled = true;
          panelPosition = "follow_bar";
          randomEnabled = false;
          randomIntervalSec = 300;
          recursiveSearch = true;
          setWallpaperOnAllMonitors = true;
          transitionDuration = 1000;
          transitionEdgeSmoothness = 0.05;
          transitionType = "wipe";
          useWallhaven = false;
          wallhavenApiKey = "";
          wallhavenCategories = "111";
          wallhavenOrder = "desc";
          wallhavenPurity = "100";
          wallhavenQuery = "gruvbox";
          wallhavenRatios = "";
          wallhavenResolutionHeight = "";
          wallhavenResolutionMode = "atleast";
          wallhavenResolutionWidth = "";
          wallhavenSorting = "relevance";
          wallpaperChangeMode = "random";
        };
      };
      # this may also be a string or a path to a JSON file,
      # but in this case must include *all* settings.
    };
  };
}
