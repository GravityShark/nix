{ ... }:

{
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
    emacsclient = {
      name = "Emacs (Client)";
      genericName = "Text Editor";
      comment = "Edit text";
      exec = "emacsclient --create-frame --alternate-editor=emacs %F";
      icon = "emacs";
      terminal = false;
      type = "Application";
      categories = [
        "Utility"
        "TextEditor"
      ];
      startupNotify = true;
      # settings = {
      #   startupWMClass = "Emacs";
      #   keywords = "emacsclient";
      # };

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
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      icon = "nvim";
      # tryExec = "nvim";
      # exec = "ghostty -e nvim \"%F\"";
      exec = "nvim \"%F\"";
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

    tomato = {
      name = "Tomato.C";
      genericName = "Timer";
      comment = "Edit text files";
      icon = "tomato";
      # tryExec = "nvim";
      # exec = "ghostty -e nvim \"%F\"";
      exec = "tomato";
      terminal = true;
      categories = [
        "Utility"
      ];
    };
  };
}
