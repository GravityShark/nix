{ ... }:

{
  programs.keepassxc = {
    enable = true;
    settings = {
      Browser.Enabled = true;

      PasswordGenerator = {
        AdditionalChars = "";
        ExcludedChars = "";
        Length = 40;
        SpecialChars = true;
        Type = 0;
        WordCase = 2;
        WordCount = 7;
        WordSeparator = "-";
      };

      SSHAgent.Enabled = true;
    };
  };
}
