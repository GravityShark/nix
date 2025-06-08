{ lib, pkgs, ... }:

{
  # Read the doom emacs line of ./dump/README.md

  # Emacs service
  services.emacs.enable = true;

  # Doom emacs
  home.file.".doom.d".source = dump/.doom.d;

  # Automatic doom sync everytime using home-manager switch
  home.activation.doomSync = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -x "$HOME/.emacs.d/bin/doom" ]; then
      export PATH="${pkgs.emacs}/bin:${pkgs.git}/bin:$PATH"
      echo "Running doom sync..."
      "$HOME/.emacs.d/bin/doom" sync || echo "doom sync failed, continuing anyway"
    else
      echo "doom binary not found, skipping doom sync"
    fi
  '';

  # Desktop file

  xdg.desktopEntries = {
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
  };
}
