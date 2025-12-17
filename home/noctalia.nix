{
  config,
  pkgs,
  noctalia,
  ...
}:

{
  imports = [ noctalia ];
  home.packages = [ pkgs.wdisplays ];
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "noctalia-shell ipc call lockScreen lock";
      }
    ];
    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
      }
      {
        timeout = 180;
        command = "noctalia-shell ipc call lockScreen lock";
      }
      {
        timeout = 300;
        command = "systemctl suspend";
      }
    ];
  };

  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/Tranquility.png";
      # wallpapers = {
      #   "eDP-1" = "${config.home.homeDirectory}/Pictures/Wallpapers/Tranquility.png";
      # };
    };
  };

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;
    settings = {
      appLauncher = {
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        enableClipPreview = true;
        enableClipboardHistory = true;
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
        visualizerQuality = "high";
        visualizerType = "none";
        volumeOverdrive = true;
        volumeStep = 5;
      };
      bar = {
        capsuleOpacity = 0;
        density = "mini";
        exclusive = true;
        floating = false;
        marginHorizontal = 0;
        marginVertical = {
        };
        monitors = [

        ];
        outerCorners = false;
        position = "bottom";
        showCapsule = true;
        showOutline = false;
        transparent = false;
        widgets = {
          center = [
            {
              characterCount = 1;
              colorizeIcons = true;
              enableScrollWheel = false;
              followFocusedScreen = false;
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "index";
              showApplications = false;
              showLabelsOnlyWhenOccupied = true;
            }
          ];
          left = [
            {
              id = "plugin:launcher-button";
            }
          ];
          right = [
            {
              displayMode = "onhover";
              id = "WiFi";
            }
            {
              displayMode = "alwaysShow";
              id = "Volume";
            }
            {
              deviceNativePath = "";
              displayMode = "alwaysShow";
              id = "Battery";
              showNoctaliaPerformance = true;
              showPowerProfiles = true;
              warningThreshold = 30;
            }
            {
              customFont = "";
              formatHorizontal = "ddd-MM-dd  HH:mm:ss";
              formatVertical = "HH mm";
              id = "Clock";
              useCustomFont = false;
              usePrimaryColor = true;
            }
            {
              colorizeDistroLogo = true;
              colorizeSystemIcon = "primary";
              customIconPath = "";
              enableColorization = true;
              icon = "adjustments-alt";
              id = "ControlCenter";
              useDistroLogo = true;
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
            enabled = true;
            id = "timer-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
        ];
      };
      colorSchemes = {
        darkMode = false;
        generateTemplatesForPredefined = true;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        matugenSchemeType = "scheme-fruit-salad";
        predefinedScheme = "Gruvbox";
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
              id = "Notifications";
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
          ];
          right = [
            {
              id = "Bluetooth";
            }
            {
              enableOnStateLogic = true;
              generalTooltipText = "Syncthing";
              icon = "affiliate";
              id = "CustomButton";
              onClicked = "toggle-syncthing";
              onMiddleClicked = "pkill syncthing";
              onRightClicked = "syncthing --no-browser";
              stateChecksJson = "[{\"command\":\"curl http://127.0.0.1:8384/rest/system/ping\",\"icon\":\"\"}]";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "PowerProfile";
            }
          ];
        };
      };
      desktopWidgets = {
        editMode = false;
        enabled = true;
        monitorWidgets = [
          {
            name = "eDP-1";
            widgets = [
              {
                id = "MediaPlayer";
                showBackground = true;
                visualizerType = "";
                x = 1592;
                y = 980;
              }
            ];
          }
        ];
      };
      dock = {
        backgroundOpacity = 1;
        colorizeIcons = true;
        deadOpacity = {
        };
        displayMode = "exclusive";
        enabled = false;
        floatingRatio = 1;
        inactiveIndicators = false;
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
        animationDisabled = true;
        animationSpeed = 1;
        avatarImage = "/home/gravity/.face";
        boxRadiusRatio = 1;
        compactLockScreen = false;
        dimmerOpacity = {
        };
        enableShadows = false;
        forceBlackScreenCorners = false;
        iRadiusRatio = 0;
        language = "";
        lockOnSuspend = true;
        radiusRatio = 0;
        scaleRatio = 1.0;
        screenRadiusRatio = 0;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showHibernateOnLockScreen = true;
        showScreenCorners = false;
        showSessionButtonsOnLockScreen = true;
      };
      hooks = {
        darkModeChange = "";
        enabled = false;
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
        use12hourFormat = false;
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
        backgroundOpacity = 1;
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
        backgroundOpacity = 1;
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
        directory = "/home/gravity/Videos/Screencasts";
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
            countdownEnabled = true;
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
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = false;
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
          }
        ];
        showHeader = false;
      };
      settingsVersion = 31;
      systemMonitor = {
        cpuCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        cpuWarningThreshold = 80;
        criticalColor = "";
        diskCriticalThreshold = 90;
        diskPollingInterval = 3000;
        diskWarningThreshold = 80;
        enableNvidiaGpu = false;
        gpuCriticalThreshold = 90;
        gpuPollingInterval = 3000;
        gpuWarningThreshold = 80;
        memCriticalThreshold = 90;
        memPollingInterval = 3000;
        memWarningThreshold = 80;
        networkPollingInterval = 3000;
        tempCriticalThreshold = 90;
        tempPollingInterval = 3000;
        tempWarningThreshold = 80;
        useCustomColors = false;
        warningColor = "";
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
        gtk = true;
        kcolorscheme = true;
        kitty = false;
        niri = true;
        pywalfox = false;
        qt = true;
        spicetify = false;
        telegram = false;
        vicinae = true;
        walker = false;
        wezterm = false;
        yazi = false;
        zed = false;
      };
      ui = {
        fontDefault = "Aporetic Sans";
        fontDefaultScale = 1.4;
        fontFixed = "Aporetic Sans Mono";
        fontFixedScale = 1.5;
        panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;
        settingsPanelMode = "attached";
        tooltipsEnabled = true;
      };
      wallpaper = {
        directory = "/home/gravity/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = true;
        monitorDirectories = [

        ];
        overviewEnabled = false;
        panelPosition = "follow_bar";
        randomEnabled = false;
        randomIntervalSec = 300;
        recursiveSearch = true;
        setWallpaperOnAllMonitors = true;
        transitionDuration = 1000;
        transitionEdgeSmoothness = {
        };
        transitionType = "stripes";
        useWallhaven = false;
        wallhavenCategories = "111";
        wallhavenOrder = "desc";
        wallhavenPurity = "100";
        wallhavenQuery = "gruvbox";
        wallhavenResolutionHeight = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenSorting = "relevance";
      };
    };
    # this may also be a string or a path to a JSON file,
    # but in this case must include *all* settings.
  };
}
