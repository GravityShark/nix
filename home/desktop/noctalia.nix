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
      brightnessctl
      notify-desktop
      pwvucontrol
      wdisplays
      wl-mirror
      # (writers.writeDashBin "noct-lock" ''
      #   ${
      #     inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
      #   }/bin/noctalia-shell ipc call lockScreen lock;
      # '')

      (writers.writeDashBin "noctalia-performance" ''
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
      '')
    ];

    # systemd.user.services = {
    #   noctalia-performance = {
    #     Unit = {
    #       Description = "Noctalia Performance on power-profiles-daemon change";
    #       After = [ "graphical.target" ];
    #     };
    #     Service = {
    #       ExecStart = ''
    #         ${inputs.ppd-dbus-hook.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/ppd-dbus-hook \
    #           "${
    #             inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #           }/bin/noctalia-shell ipc call powerProfile enableNoctaliaPerformance" \
    #           "${
    #             inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #           }/bin/noctalia-shell ipc call powerProfile disableNoctaliaPerformance" \
    #           "${
    #             inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    #           }/bin/noctalia-shell ipc call powerProfile enableNoctaliaPerformance"
    #       '';
    #       Restart = "on-failure";
    #     };
    #     Install.WantedBy = [ "graphical.target" ];
    #   };
    # };

    programs.noctalia-shell = {
      enable = true;
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
          fancy-audiovisualizer = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          file-search = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          mirror-mirror = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          privacy-indicator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          usb-drive-manager = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          web-search = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 2;
      };

      pluginSettings = {
        privacy-indicator = {
          hideInactive = true;
          enableToast = true;
          removeMargins = false;
          iconSpacing = 4;
          activeColor = "primary";
          inactiveColor = "none";
          micFilterRegex = "";
          camFilterRegex = "";
        };
        usb-drive-manager = {
          autoMount = false;
          fileBrowser = "xdg-open";
          terminalCommand = "ghostty";
          showNotifications = true;
          hideWhenEmpty = true;
          showBadge = true;
          iconColor = "none";
        };
        web-search = {
          search_engine = "DuckDuckGo";
          direct_url = true;
          show_suggestions = true;
          max_results = 5;
        };
      };
      settings = {
        appLauncher = {
          autoPasteClipboard = false;
          clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
          clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
          clipboardWrapText = true;
          customLaunchPrefix = "";
          customLaunchPrefixEnabled = false;
          density = "compact";
          enableClipPreview = true;
          enableClipboardChips = true;
          enableClipboardHistory = true;
          enableClipboardSmartIcons = true;
          enableSessionSearch = true;
          enableSettingsSearch = false;
          enableWindowsSearch = true;
          iconMode = "tabler";
          ignoreMouseInput = false;
          overviewLayer = true;
          pinnedApps = [

          ];
          position = "center";
          screenshotAnnotationTool = "";
          showCategories = true;
          showIconBackground = false;
          sortByMostUsed = true;
          terminalCommand = "ghostty -e";
          viewMode = "list";
        };
        audio = {
          mprisBlacklist = [

          ];
          preferredPlayer = "youtube";
          spectrumFrameRate = 60;
          spectrumMirrored = true;
          visualizerType = "none";
          volumeFeedback = false;
          volumeFeedbackSoundFile = "";
          volumeOverdrive = true;
          volumeStep = 5;
        };
        bar = {
          autoHideDelay = 500;
          autoShowDelay = 150;
          backgroundOpacity = 1;
          barType = "simple";
          capsuleColorKey = "none";
          capsuleOpacity = 1;
          contentPadding = 2;
          density = "mini";
          displayMode = "always_visible";
          enableExclusionZoneInset = true;
          fontScale = 1;
          frameRadius = 12;
          frameThickness = 8;
          hideOnOverview = false;
          marginHorizontal = 0;
          marginVertical = 5;
          middleClickAction = "none";
          middleClickCommand = "";
          middleClickFollowMouse = false;
          monitors = [

          ];
          mouseWheelAction = "none";
          mouseWheelWrap = true;
          outerCorners = false;
          position = "bottom";
          reverseScroll = false;
          rightClickAction = "controlCenter";
          rightClickCommand = "";
          rightClickFollowMouse = true;
          screenOverrides = [

          ];
          showCapsule = false;
          showOnWorkspaceSwitch = true;
          showOutline = false;
          useSeparateOpacity = false;
          widgetSpacing = 6;
          widgets = {
            center = [
              {
                blacklist = [

                ];
                chevronColor = "none";
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
                emptyColor = "secondary";
                enableScrollWheel = false;
                focusedColor = "primary";
                followFocusedScreen = false;
                groupedBorderOpacity = 0;
                hideUnoccupied = false;
                iconScale = 1;
                id = "Workspace";
                labelMode = "index";
                occupiedColor = "secondary";
                pillSize = 0.6;
                reverseScroll = false;
                showApplications = true;
                showBadge = true;
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
                iconColor = "none";
                id = "Launcher";
              }
              {
                id = "Spacer";
                width = 1;
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
                textColor = "none";
                useFixedWidth = false;
                visualizerType = "wave";
              }
            ];
            right = [
              {
                id = "plugin:privacy-indicator";
              }
              {
                id = "plugin:usb-drive-manager";
              }
              {
                compactMode = true;
                diskPath = "/";
                iconColor = "none";
                id = "SystemMonitor";
                showCpuFreq = false;
                showCpuTemp = true;
                showCpuUsage = false;
                showDiskAvailable = false;
                showDiskUsage = true;
                showDiskUsageAsPercent = false;
                showGpuTemp = false;
                showLoadAverage = false;
                showMemoryAsPercent = false;
                showMemoryUsage = true;
                showNetworkStats = false;
                showSwapUsage = false;
                textColor = "none";
                useMonospaceFont = true;
              }
              {
                id = "Spacer";
                width = 7;
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Network";
                textColor = "none";
              }
              {
                id = "Spacer";
                width = 12;
              }
              {
                displayMode = "onhover";
                iconColor = "none";
                id = "Volume";
                middleClickCommand = "pwvucontrol || pavucontrol";
                textColor = "none";
              }
              {
                id = "Spacer";
                width = 8;
              }
              {
                deviceNativePath = "";
                displayMode = "icon-always";
                hideIfIdle = false;
                hideIfNotDetected = true;
                id = "Battery";
                showNoctaliaPerformance = true;
                showPowerProfiles = true;
              }
              {
                id = "Spacer";
                width = 1;
              }
              {
                clockColor = "none";
                customFont = "Aporetic Sans Mono";
                formatHorizontal = "ddd dd hh:mm AP";
                formatVertical = "HH mm";
                id = "Clock";
                tooltipFormat = "HH:mm ddd, MMM dd";
                useCustomFont = true;
              }
            ];
          };
        };
        brightness = {
          backlightDeviceMappings = [

          ];
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
          darkMode = true;
          generationMethod = "tonal-spot";
          manualSunrise = "06:30";
          manualSunset = "18:30";
          monitorForColors = "";
          predefinedScheme = "Noctalia (default)";
          schedulingMode = "off";
          syncGsettings = true;
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
              enabled = false;
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
                id = "WallpaperSelector";
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
                id = "plugin:mirror-mirror";
              }
              {
                id = "NightLight";
              }
            ];
          };
        };
        desktopWidgets = {
          enabled = true;
          gridSnap = true;
          gridSnapScale = false;
          monitorWidgets = [
            {
              name = "eDP-1";
              widgets = [
                {
                  id = "plugin:fancy-audiovisualizer";
                  showBackground = true;
                  x = 20;
                  y = 740;
                }
              ];
            }
          ];
          overviewEnabled = true;
        };
        dock = {
          animationSpeed = 1;
          backgroundOpacity = 1;
          colorizeIcons = true;
          deadOpacity = 0.6;
          displayMode = "auto_hide";
          dockType = "floating";
          enabled = false;
          floatingRatio = 1;
          groupApps = false;
          groupClickAction = "cycle";
          groupContextMenuMode = "extended";
          groupIndicatorStyle = "dots";
          inactiveIndicators = true;
          indicatorColor = "primary";
          indicatorOpacity = 0.6;
          indicatorThickness = 3;
          launcherIcon = "";
          launcherIconColor = "none";
          launcherPosition = "end";
          launcherUseDistroLogo = false;
          monitors = [

          ];
          onlySameOutput = true;
          pinnedApps = [

          ];
          pinnedStatic = false;
          position = "bottom";
          showDockIndicator = false;
          showLauncherIcon = false;
          sitOnFrame = false;
          size = 1;
        };
        general = {
          allowPanelsOnScreenWithoutBar = true;
          allowPasswordWithFprintd = false;
          animationDisabled = false;
          animationSpeed = 2;
          autoStartAuth = false;
          avatarImage = "";
          boxRadiusRatio = 1;
          clockFormat = "hh\\nmm";
          clockStyle = "custom";
          compactLockScreen = false;
          dimmerOpacity = 0.5;
          enableBlurBehind = true;
          enableLockScreenCountdown = true;
          enableLockScreenMediaControls = false;
          enableShadows = true;
          forceBlackScreenCorners = false;
          iRadiusRatio = 0.15;
          keybinds = {
            keyDown = [
              "Down"
            ];
            keyEnter = [
              "Return"
              "Enter"
            ];
            keyEscape = [
              "Esc"
            ];
            keyLeft = [
              "Left"
            ];
            keyRemove = [
              "Del"
            ];
            keyRight = [
              "Right"
            ];
            keyUp = [
              "Up"
            ];
          };
          language = "";
          lockOnSuspend = true;
          lockScreenAnimations = false;
          lockScreenBlur = 0;
          lockScreenCountdownDuration = 10000;
          lockScreenMonitors = [

          ];
          lockScreenTint = 0;
          passwordChars = false;
          radiusRatio = 0.15;
          reverseScroll = false;
          scaleRatio = 1;
          screenRadiusRatio = 0.3;
          shadowDirection = "center";
          shadowOffsetX = 0;
          shadowOffsetY = 0;
          showChangelogOnStartup = true;
          showHibernateOnLockScreen = true;
          showScreenCorners = false;
          showSessionButtonsOnLockScreen = true;
          smoothScrollEnabled = true;
          telemetryEnabled = true;
        };
        hooks = {
          colorGeneration = "";
          darkModeChange = "";
          enabled = false;
          performanceModeDisabled = "";
          performanceModeEnabled = "";
          screenLock = "";
          screenUnlock = "";
          session = "";
          startup = "";
          wallpaperChange = "";
        };
        idle = {
          customCommands = "[]";
          enabled = false;
          fadeDuration = 5;
          lockCommand = "";
          lockTimeout = 240;
          resumeLockCommand = "";
          resumeScreenOffCommand = "";
          resumeSuspendCommand = "";
          screenOffCommand = "notify-desktop \"yo\"";
          screenOffTimeout = 3;
          suspendCommand = "";
          suspendTimeout = 300;
        };
        location = {
          analogClockInCalendar = true;
          autoLocate = false;
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
          weatherTaliaMascotAlways = false;
        };
        network = {
          bluetoothAutoConnect = true;
          bluetoothDetailsViewMode = "grid";
          bluetoothHideUnnamedDevices = false;
          bluetoothRssiPollIntervalMs = 10000;
          bluetoothRssiPollingEnabled = false;
          disableDiscoverability = false;
          networkPanelView = "wifi";
          wifiDetailsViewMode = "grid";
        };
        nightLight = {
          autoSchedule = false;
          dayTemp = "1000";
          enabled = false;
          forced = true;
          manualSunrise = "06:30";
          manualSunset = "18:30";
          nightTemp = "1000";
        };
        noctaliaPerformance = {
          disableDesktopWidgets = true;
          disableWallpaper = false;
        };
        notifications = {
          backgroundOpacity = 1;
          clearDismissed = true;
          criticalUrgencyDuration = 15;
          density = "default";
          enableBatteryToast = true;
          enableKeyboardLayoutToast = true;
          enableMarkdown = false;
          enableMediaToast = false;
          enabled = true;
          location = "top_right";
          lowUrgencyDuration = 3;
          monitors = [

          ];
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
          backgroundOpacity = 1;
          enabled = true;
          enabledTypes = [
            0
            1
            2
            3
          ];
          location = "top_left";
          monitors = [

          ];
          overlayLayer = false;
        };
        plugins = {
          autoUpdate = true;
          notifyUpdates = true;
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
              keybind = "1";
            }
            {
              action = "logout";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "2";
            }
            {
              action = "suspend";
              command = "";
              countdownEnabled = false;
              enabled = true;
              keybind = "3";
            }
            {
              action = "hibernate";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "4";
            }
            {
              action = "reboot";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "5";
            }
            {
              action = "rebootToUefi";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "6";
            }
            {
              action = "shutdown";
              command = "";
              countdownEnabled = true;
              enabled = true;
              keybind = "7";
            }
            {
              action = "userspaceReboot";
              command = "";
              countdownEnabled = true;
              enabled = false;
              keybind = "";
            }
          ];
          showHeader = false;
          showKeybinds = true;
        };
        settingsVersion = 49;
        systemMonitor = {
          batteryCriticalThreshold = 5;
          batteryWarningThreshold = 20;
          cpuCriticalThreshold = 90;
          cpuWarningThreshold = 80;
          criticalColor = "#cc241d";
          diskAvailCriticalThreshold = 10;
          diskAvailWarningThreshold = 20;
          diskCriticalThreshold = 90;
          diskWarningThreshold = 90;
          enableDgpuMonitoring = false;
          externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
          gpuCriticalThreshold = 90;
          gpuWarningThreshold = 80;
          memCriticalThreshold = 70;
          memWarningThreshold = 70;
          swapCriticalThreshold = 90;
          swapWarningThreshold = 80;
          tempCriticalThreshold = 60;
          tempWarningThreshold = 60;
          useCustomColors = false;
          warningColor = "#458588";
        };
        templates = {
          activeTemplates = [

          ];
          enableUserTheming = false;
        };
        ui = {
          boxBorderEnabled = true;
          fontDefault = "Aporetic Sans";
          fontDefaultScale = 1;
          fontFixed = "Aporetic Sans Mono";
          fontFixedScale = 1.25;
          panelBackgroundOpacity = 1;
          panelsAttachedToBar = true;
          scrollbarAlwaysVisible = true;
          settingsPanelMode = "centered";
          settingsPanelSideBarCardStyle = false;
          tooltipsEnabled = true;
          translucentWidgets = false;
        };
        wallpaper = {
          automationEnabled = false;
          directory = "/home/${config.home.username}/Pictures/Wallpapers";
          enableMultiMonitorDirectories = false;
          enabled = true;
          favorites = [

          ];
          fillColor = "#00dafc";
          fillMode = "crop";
          hideWallpaperFilenames = true;
          linkLightAndDarkWallpapers = true;
          monitorDirectories = [

          ];
          overviewBlur = 0.4;
          overviewEnabled = false;
          overviewTint = 0.6;
          panelPosition = "follow_bar";
          randomIntervalSec = 300;
          setWallpaperOnAllMonitors = true;
          showHiddenFiles = false;
          skipStartupTransition = false;
          solidColor = "#1a1a2e";
          sortOrder = "name";
          transitionDuration = 1000;
          transitionEdgeSmoothness = 0.05;
          transitionType = [
            "random"
          ];
          useOriginalImages = false;
          useSolidColor = false;
          useWallhaven = false;
          viewMode = "recursive";
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
    };
  };
}
