{ ... }:

{
  programs.keepassxc = {
    enable = true;

    settings = {
      General = {
        ConfigVersion = 2;
        MinimizeAfterUnlock = true;
      };

      GUI = {
        MinimizeOnClose = true;
        MinimizeOnStartup = true;
        MinimizeToTray = true;
        ShowTrayIcon = false;
        ToolButtonStyle = 0;
        TrayIconAppearance = "monochrome-dark";
      };

      Security = {
        IconDownloadFallback = true;
        LockDatabaseIdle = true;
      };

      Browser.Enabled = true;

      PasswordGenerator = {
        AdditionalChars = "";
        ExcludedChars = "";
        Length = 40;
        SpecialChars = true;
        Type = 1;
        WordCase = 0;
        WordCount = 7;
        WordSeparator = "\\x20";
      };

      SSHAgent.Enabled = true;
    };
  };
}
