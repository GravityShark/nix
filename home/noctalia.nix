{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  noctalia = inputs.noctalia;
in
{
  imports = [ noctalia.homeModules.default ];
  home.packages = with pkgs; [
    wdisplays
  ];
  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${
          noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/noctalia-shell ipc call lockScreen lock";
      }
    ];
    timeouts = [
      {
        timeout = 120;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors";
      }
      {
        timeout = 180;
        command = "${
          noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        }/bin/noctalia-shell ipc call lockScreen lock";
      }
      {
        timeout = 300;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };

  home.file.".cache/noctalia/wallpapers.json" = lib.mkDefault {
    text = builtins.toJSON {
      defaultWallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/Tranquility.png";
      # wallpapers = {
      #   "eDP-1" = "${config.home.homeDirectory}/Pictures/Wallpapers/Tranquility.png";
      # };
    };
  };

  home.file.".config/noctalia/plugins.json" = {
    text = builtins.toJSON {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        launcher-button = {
          enabled = true;
        };
      };
      version = 1;
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
        capsuleOpacity = 1.0;
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
              showApplications = true;
              showLabelsOnlyWhenOccupied = true;
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
              id = "plugin:launcher-button";
            }
          ];
          right = [
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
              id = "Spacer";
              width = 2;
            }
            {
              displayMode = "alwaysShow";
              id = "Volume";
            }
            {
              id = "Spacer";
              width = 3;
            }
            {
              deviceNativePath = "";
              displayMode = "alwaysShow";
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = true;
              warningThreshold = 30;
            }
            {
              id = "Spacer";
              width = 7;
            }
            {
              displayMode = "alwaysHide";
              id = "WiFi";
            }
            {
              id = "Spacer";
              width = 2;
            }
            {
              customFont = "";
              formatHorizontal = "ddd dd hh:mm AP";
              formatVertical = "HH mm";
              id = "Clock";
              useCustomFont = false;
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
        darkMode = false;
        generateTemplatesForPredefined = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        matugenSchemeType = "scheme-fruit-salad";
        # predefinedScheme = "Gruvbox";
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
              onClicked = "if (systemctl is-active --quiet --user syncthing.service); then systemctl stop --user syncthing.service && notify-desktop 'Stopping Syncthing'; else systemctl start --user syncthing.service && notify-desktop 'Starting Syncthing'; fi";
              onMiddleClicked = "pkill syncthing";
              onRightClicked = "syncthing --no-browser";
              stateChecksJson = "[{\"command\":\"systemctl is-active --quiet --user syncthing.service\",\"icon\":\"\"}]";
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
        gridSnap = true;
        monitorWidgets = [
          {
            name = "eDP-1";
            widgets = [
              {
                hideMode = "hidden";
                id = "MediaPlayer";
                showBackground = true;
                visualizerType = "";
                visualizerVisibility = "always";
                x = 20;
                y = 960;
              }
            ];
          }
        ];
      };
      dock = {
        animationSpeed = 1;
        backgroundOpacity = 1.0;
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
        animationDisabled = true;
        animationSpeed = 1;
        avatarImage = "/home/gravity/Notes/assets/gravityshark.png";
        boxRadiusRatio = 1;
        compactLockScreen = false;
        dimmerOpacity = 0.2;
        enableShadows = false;
        forceBlackScreenCorners = false;
        iRadiusRatio = 0;
        language = "";
        lockOnSuspend = true;
        radiusRatio = 0;
        scaleRatio = 0.9;
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
        backgroundOpacity = 1.0;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        enabled = true;
        location = "bottom_right";
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
        backgroundOpacity = 1.0;
        enabled = true;
        enabledTypes = [
          0
          1
          2
          3
        ];
        location = "bottom_right";
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
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = false;
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = false;
          }
        ];
        showHeader = false;
      };
      settingsVersion = 31;
      systemMonitor = {
        cpuCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        cpuWarningThreshold = 80;
        criticalColor = "#cc241d";
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
        fontDefault = "Aporetic Sans";
        fontDefaultScale = 1.25;
        fontFixed = "Aporetic Sans Mono";
        fontFixedScale = 1.25;
        panelBackgroundOpacity = 1.0;
        panelsAttachedToBar = true;
        settingsPanelMode = "centered";
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
        transitionEdgeSmoothness = 0.05;
        transitionType = "wipe";
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
