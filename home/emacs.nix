{ ... }:

{
  # Read the doom emacs line of ./dump/README.md

  # Emacs service
  services.emacs.enable = true;

  # Doom emacs
  home.file.".doom.d".source = dump/.doom.d;

  # Desktop file
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
}
