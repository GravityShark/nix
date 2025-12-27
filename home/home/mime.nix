{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
      # "application/pdf" = [ "org.gnome.Evince.desktop" ];
      "application/x-extension-html" = [ "zen.desktop" ];
      "application/x-extension-htm" = [ "zen.desktop" ];
      "application/x-extension-shtml" = [ "zen.desktop" ];
      "application/x-extension-xhtml" = [ "zen.desktop" ];
      "application/x-extension-xht" = [ "zen.desktop" ];
      "application/xhtml+xml" = [ "zen.desktop" ];
      # "image/gif" = [ "org.gnome.Loupe.desktop" ];
      # "image/jpeg" = [ "org.gnome.Loupe.desktop;" ];
      # "image/*" = [ "org.gnome.Loupe.desktop" ];
      # "image/png" = [ "org.gnome.Loupe.desktop" ];
      "text/html" = [ "zen.desktop" ];
      # "text/org" = [ "emacsclient.desktop" ];
      # "text/plain" = [ "nvim.desktop" ];
      # "text/x-bibtex" = [ "nvim.desktop" ];
      # "text/x-csrc" = [ "nvim.desktop" ];
      # "text/x-pascal" = [ "nvim.desktop" ];
      "x-scheme-handler/chrome" = [ "zen.desktop" ];
      "x-scheme-handler/https" = [ "zen.desktop" ];
      "x-scheme-handler/http" = [ "zen.desktop" ];
      # "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      # "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
    };
  };
}
