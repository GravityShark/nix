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
      app2unit
      gpu-screen-recorder
      notify-desktop
      (writers.writeDashBin "lock" ''
        ${
          inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
        }/bin/noctalia-shell ipc call lockScreen lock;
      '')
    ];

    systemd.user.services = {
      noctalia-performance = {
        Unit = {
          Description = "Noctalia Performance on power-profiles-daemon change";
          After = [ "noctalia-shell.service" ];
          PartOf = [ "noctalia-shell.service" ];
        };

        Service = {
          ExecStart = ''
            ${inputs.ppd-dbus-hook.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ppd-dbus-hook \
                         "${
                           inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
                         }/bin/noctalia-shell ipc call powerProfile enableNoctaliaPerformance" \
                         "${
                           inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
                         }/bin/noctalia-shell ipc call powerProfile disableNoctaliaPerformance" \
                         "${
                           inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
                         }/bin/noctalia-shell ipc call powerProfile enableNoctaliaPerformance"
          '';
          Restart = "on-failure";
        };
        Install.WantedBy = [ "noctalia-shell.service" ];
      };
    };

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
                  "enabled": true,
                  "sourceUrl": "https://github.com/noctalia-dev/noctalia-plugins"
              },
              "screen-recorder": {
                  "enabled": true,
                  "sourceUrl": "https://github.com/noctalia-dev/noctalia-plugins"
              }
          },
          "version": 2
      }
    '';

    xdg.configFile."noctalia/plugins/screen-recorder/settings.json".text = ''
      {
        "directory": "~/Videos/Screencasts/",
        "filenamePattern": "yyyyMMdd_HHmmss",
        "frameRate": "60",
        "audioCodec": "opus",
        "videoCodec": "av1",
        "quality": "medium",
        "colorRange": "limited",
        "showCursor": true,
        "copyToClipboard": true,
        "audioSource": "both",
        "videoSource": "portal"
      }
    '';

    programs.noctalia-shell = {
      enable = true;
      systemd.enable = true;
      settings = {
        appLauncher = {
          autoPasteClipboard = false;
          clipboardWrapText = true;
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          enableClipPreview = true;
          enableClipboardHistory = true;
          iconMode = "tabler";
          ignoreMouseInput = false;
          pinnedApps = [ ];
          position = "center";
          screenshotAnnotationTool = "";
          showCategories = true;
          showIconBackground = false;
          sortByMostUsed = true;
          terminalCommand = "ghostty -e";
          useApp2Unit = true;
          viewMode = "list";
        };
        audio = {
          cavaFrameRate = 60;
          mprisBlacklist = [ ];
          preferredPlayer = "youtube";
          visualizerType = "none";
          volumeOverdrive = true;
          volumeStep = 5;
        };
        bar = {
          density = "mini";
          exclusive = true;
          floating = false;
          marginHorizontal = 0;
          marginVertical = 5;
          monitors = [ ];
          outerCorners = false;
          position = "bottom";
          showCapsule = false;
          showOutline = false;
          useSeparateOpacity = false;
          widgets = {
            center = [
              {
                blacklist = [ ];
                colorizeIcons = false;
                drawerEnabled = true;
                hidePassive = false;
                id = "Tray";
                pinned = [ ];
              }
              {
                characterCount = 1;
                colorizeIcons = true;
                enableScrollWheel = false;
                followFocusedScreen = false;
                groupedBorderOpacity = 0.0;
                hideUnoccupied = false;
                iconScale = 1;
                id = "Workspace";
                labelMode = "index";
                showApplications = true;
                showLabelsOnlyWhenOccupied = false;
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
                id = "Spacer";
                width = 2;
              }
              {
                icon = "rocket";
                id = "Launcher";
                usePrimaryColor = false;
              }
              {
                id = "Spacer";
                width = 1;
              }
              {
                id = "plugin:screen-recorder";
              }
              {
                compactMode = false;
                compactShowAlbumArt = true;
                compactShowVisualizer = false;
                hideMode = "hidden";
                hideWhenIdle = false;
                id = "MediaMini";
                maxWidth = 700;
                panelShowAlbumArt = true;
                panelShowVisualizer = true;
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
                showLoadAverage = false;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                showNetworkStats = false;
                useMonospaceFont = true;
                usePrimaryColor = false;
              }
              {
                id = "Spacer";
                width = 7;
              }
              {
                displayMode = "alwaysShow";
                id = "Network";
              }
              {
                id = "Spacer";
                width = 12;
              }
              {
                displayMode = "onhover";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol";
              }
              {
                id = "Spacer";
                width = 5;
              }
              {
                deviceNativePath = "";
                displayMode = "alwaysShow";
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
                warningThreshold = 30;
              }
              {
                id = "Spacer";
                width = 1;
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
          darkMode = false;
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
              enabled = false;
              id = "media-sysmon-card";
            }
          ];
          diskPath = "/";
          position = "close_to_bar_button";
          shortcuts = {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
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
                enableOnStateLogic = false;
                generalTooltipText = "Monitor Configuration";
                icon = "user-screen";
                id = "CustomButton";
                onClicked = "wdisplays";
                onMiddleClicked = "";
                onRightClicked = "";
                stateChecksJson = "[]";
              }
              {
                id = "WallpaperSelector";
              }
              {
                id = "plugin:screen-recorder";
              }
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
          colorizeIcons = true;
          deadOpacity = 0.6;
          displayMode = "auto_hide";
          enabled = false;
          floatingRatio = 1;
          inactiveIndicators = true;
          monitors = [ ];
          onlySameOutput = true;
          pinnedApps = [ ];
          pinnedStatic = false;
          position = "bottom";
          size = 1;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          animationDisabled = false;
          animationSpeed = 2;
          avatarImage = "/home/gravity/Notes/assets/gravityshark.png";
          boxRadiusRatio = 1;
          compactLockScreen = false;
          dimmerOpacity = 0.5;
          enableShadows = true;
          forceBlackScreenCorners = false;
          iRadiusRatio = 0.15;
          language = "";
          lockOnSuspend = true;
          radiusRatio = 0.15;
          scaleRatio = 1;
          screenRadiusRatio = 0.3;
          shadowDirection = "center";
          shadowOffsetX = 0;
          shadowOffsetY = 0;
          showChangelogOnStartup = true;
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
          hideWeatherCityName = false;
          hideWeatherTimezone = false;
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
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          bluetoothRssiPollIntervalMs = 10000;
          bluetoothRssiPollingEnabled = false;
          wifiDetailsViewMode = "grid";
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
          criticalUrgencyDuration = 15;
          enableKeyboardLayoutToast = true;
          enabled = true;
          location = "bottom_right";
          lowUrgencyDuration = 3;
          monitors = [ ];
          normalUrgencyDuration = 8;
          overlayLayer = false;
          respectExpireTimeout = false;
          saveToHistory = {
            critical = true;
            low = true;
            normal = true;
          };
          sounds = {
            criticalSoundFile = "";
            enabled = true;
            excludedApps = "vesktop,firefox,chrome,chromium,edge";
            lowSoundFile = "";
            normalSoundFile = "";
            separateSounds = false;
            volume = 0.75;
          };
        };
        osd = {
          autoHideMs = 2000;
          enabled = true;
          enabledTypes = [
            0
            1
            2
            3
          ];
          location = "bottom_left";
          monitors = [ ];
          overlayLayer = false;
        };
        sessionMenu = {
          countdownDuration = 5000;
          enableCountdown = true;
          largeButtonsLayout = "grid";
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
        settingsVersion = 39;
        systemMonitor = {
          cpuCriticalThreshold = 90;
          cpuPollingInterval = 3000;
          cpuWarningThreshold = 80;
          criticalColor = "#cc241d";
          diskCriticalThreshold = 90;
          diskPollingInterval = 3000;
          diskWarningThreshold = 90;
          enableDgpuMonitoring = false;
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
          gpuCriticalThreshold = 90;
          gpuPollingInterval = 3000;
          gpuWarningThreshold = 80;
          loadAvgPollingInterval = 3000;
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
          discord = false;
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
          zenBrowser = false;
        };
        ui = {
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          boxBorderEnabled = true;
          fontDefault = "Aporetic Sans";
          fontDefaultScale = 1;
          fontFixed = "Aporetic Sans Mono";
          fontFixedScale = 1.25;
          networkPanelView = "wifi";
          panelsAttachedToBar = true;
          settingsPanelMode = "centered";
          tooltipsEnabled = true;
          wifiDetailsViewMode = "grid";
        };
        wallpaper = {
          directory = "/home/gravity/Pictures/Wallpapers";
          enableMultiMonitorDirectories = false;
          enabled = true;
          fillColor = "#000000";
          fillMode = "crop";
          hideWallpaperFilenames = true;
          monitorDirectories = [ ];
          overviewEnabled = true;
          panelPosition = "follow_bar";
          randomEnabled = false;
          randomIntervalSec = 300;
          recursiveSearch = true;
          setWallpaperOnAllMonitors = true;
          solidColor = "#1a1a2e";
          transitionDuration = 1000;
          transitionEdgeSmoothness = 0.05;
          transitionType = "random";
          useSolidColor = false;
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
