{ config, lib, ... }:

{
  options = {
    desktop-entries.enable = lib.mkEnableOption "enables generating of desktop entries";
  };

  config = lib.mkIf config.desktop-entries.enable {
    xdg.desktopEntries = {
      # firefox = {
      #   name = "Firefox";
      #   genericName = "Web Browser";
      #   exec = "firefox %U";
      #   terminal = false;
      #   categories = [
      #     "Application"
      #     "Network"
      #     "WebBrowser"
      #   ];
      #   mimeType = [
      #     "text/html"
      #     "text/xml"
      #   ];
      # };
      nvim = {
        name = "Neovim";
        genericName = "Text Editor";
        comment = "Edit text files";
        icon = "nvim";
        # tryExec = "nvim";
        # exec = "ghostty -e nvim \"%F\"";
        # exec = "tmux new-session \"exec nvim \"%F\" \"";
        exec = "nvim %F";
        terminal = true;
        categories = [
          "Utility"
          "TextEditor"
        ];
        mimeType = [
          "text/english"
          "text/plain"
          "text/x-makefile"
          "text/x-c++hdr"
          "text/x-c++src"
          "text/x-chdr"
          "text/x-csrc"
          "text/x-java"
          "text/x-moc"
          "text/x-pascal"
          "text/x-tcl"
          "text/x-tex"
          "application/x-shellscript"
          "text/x-c"
          "text/x-c++"
        ];
      };

      # tomato = {
      #   name = "Tomato.C";
      #   genericName = "Timer";
      #   comment = "Edit text files";
      #   icon = "tools-timer";
      #   # tryExec = "nvim";
      #   # exec = "ghostty -e nvim \"%F\"";
      #   exec = "sesh connect \" TOmato 🍅\"";
      #   terminal = true;
      #   categories = [
      #     "Utility"
      #   ];
      # };
    };
  };
}
