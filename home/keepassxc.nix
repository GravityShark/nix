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
        ShowTrayIcon = true;
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
        Type = 0;
        WordCase = 0;
        WordCount = 7;
        WordSeparator = " ";
      };

      SSHAgent.Enabled = true;
    };
  };
}
