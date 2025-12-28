{
  config,
  lib,
  ...
}:

{
  options = {
    home.mime.enable = lib.mkEnableOption "enables mime";
  };
  config = lib.mkIf config.home.mime.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        # "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
        # "application/pdf" = [ "org.gnome.Evince.desktop" ];
        # "application/x-extension-html" = [ "zen.desktop" ];
        # "application/x-extension-htm" = [ "zen.desktop" ];
        # "application/x-extension-shtml" = [ "zen.desktop" ];
        # "application/x-extension-xhtml" = [ "zen.desktop" ];
        # "application/x-extension-xht" = [ "zen.desktop" ];
        # "application/xhtml+xml" = [ "zen.desktop" ];
        # "image/gif" = [ "org.gnome.Loupe.desktop" ];
        # "image/jpeg" = [ "org.gnome.Loupe.desktop;" ];
        # "image/*" = [ "org.gnome.Loupe.desktop" ];
        # "image/png" = [ "org.gnome.Loupe.desktop" ];
        # "text/html" = [ "zen.desktop" ];
        # "text/org" = [ "emacsclient.desktop" ];
        # "text/plain" = [ "nvim.desktop" ];
        # "text/x-bibtex" = [ "nvim.desktop" ];
        # "text/x-csrc" = [ "nvim.desktop" ];
        # "text/x-pascal" = [ "nvim.desktop" ];
        # "x-scheme-handler/chrome" = [ "zen.desktop" ];
        # "x-scheme-handler/https" = [ "zen.desktop" ];
        # "x-scheme-handler/http" = [ "zen.desktop" ];
        # "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
        # "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];

        "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];
        "x-content/video-dvd" = [ "vlc.desktop" ];
        "x-content/video-svcd" = [ "vlc.desktop" ];
        "x-content/audio-player" = [ "vlc.desktop" ];
        "x-content/audio-cdda" = [ "vlc.desktop" ];
        "x-content/video-vcd" = [ "vlc.desktop" ];
        "video/mp4" = [ "vlc.desktop" ];
        "video/x-ms-wmv" = [ "vlc.desktop" ];
        "video/dv" = [ "vlc.desktop" ];
        "video/3gpp" = [ "vlc.desktop" ];
        "video/x-matroska" = [ "vlc.desktop" ];
        "video/x-nsv" = [ "vlc.desktop" ];
        "video/vnd.rn-realvideo" = [ "vlc.desktop" ];
        "video/x-flic" = [ "vlc.desktop" ];
        "video/3gpp2" = [ "vlc.desktop" ];
        "video/vnd.mpegurl" = [ "vlc.desktop" ];
        "video/vnd.avi" = [ "vlc.desktop" ];
        "video/webm" = [ "vlc.desktop" ];
        "video/mp2t" = [ "vlc.desktop" ];
        "video/x-theora+ogg" = [ "vlc.desktop" ];
        "video/x-ogm+ogg" = [ "vlc.desktop" ];
        "video/x-flv" = [ "vlc.desktop" ];
        "video/quicktime" = [ "vlc.desktop" ];
        "video/ogg" = [ "vlc.desktop" ];
        "video/x-anim" = [ "vlc.desktop" ];
        "video/mpeg" = [ "vlc.desktop" ];
        "text/x-c++hdr" = [ "nvim.desktop" ];
        "text/x-makefile" = [ "nvim.desktop" ];
        "text/vbscript" = [ "nvim.desktop" ];
        "text/tcl" = [ "nvim.desktop" ];
        "text/x-tex" = [ "nvim.desktop" ];
        "text/x-java" = [ "nvim.desktop" ];
        "text/x-chdr" = [ "nvim.desktop" ];
        "text/x-c++src" = [ "nvim.desktop" ];
        "text/x-moc" = [ "nvim.desktop" ];
        "text/x-pascal" = [ "nvim.desktop" ];
        "text/x-csrc" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "text/csv" = [ "onlyoffice-desktopeditors.desktop" ];
        "text/spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ];
        "text/tab-separated-values" = [ "onlyoffice-desktopeditors.desktop" ];
        "text/x-google-video-pointer" = [ "vlc.desktop" ];
        "text/html" = [ "zen-beta.desktop" ];
        "image/vnd.zbrush.pcx" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        "image/jp2" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        "image/vnd.microsoft.icon" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        "image/avif" = [ "swayimg.desktop" ];
        "image/x-portable-bitmap" = [ "swayimg.desktop" ];
        "image/png" = [ "swayimg.desktop" ];
        "image/gif" = [ "swayimg.desktop" ];
        "image/jpeg" = [ "swayimg.desktop" ];
        "image/x-portable-anymap" = [ "swayimg.desktop" ];
        "image/svg+xml" = [ "swayimg.desktop" ];
        "image/tiff" = [ "swayimg.desktop" ];
        "image/bmp" = [ "swayimg.desktop" ];
        "image/jxl" = [ "swayimg.desktop" ];
        "image/x-tga" = [ "swayimg.desktop" ];
        "image/x-exr" = [ "swayimg.desktop" ];
        "image/x-portable-pixmap" = [ "swayimg.desktop" ];
        "image/x-portable-graymap" = [ "swayimg.desktop" ];
        "image/webp" = [ "swayimg.desktop" ];
        "image/heif" = [ "swayimg.desktop" ];
        "image/x-eps" = [ "org.pwmt.zathura.desktop" ];
        "image/vnd.djvu+multipage" = [ "org.pwmt.zathura.desktop" ];
        "image/vnd.djvu" = [ "org.pwmt.zathura.desktop" ];
        "image/openraster" = [ "org.pwmt.zathura.desktop" ];
        "audio/x-ape" = [ "vlc.desktop" ];
        "audio/ogg" = [ "vlc.desktop" ];
        "audio/x-aiff" = [ "vlc.desktop" ];
        "audio/x-wavpack" = [ "vlc.desktop" ];
        "audio/vnd.dts" = [ "vlc.desktop" ];
        "audio/x-it" = [ "vlc.desktop" ];
        "audio/mp2" = [ "vlc.desktop" ];
        "audio/mp4" = [ "vlc.desktop" ];
        "audio/x-speex" = [ "vlc.desktop" ];
        "audio/vnd.wave" = [ "vlc.desktop" ];
        "audio/aac" = [ "vlc.desktop" ];
        "audio/midi" = [ "vlc.desktop" ];
        "audio/flac" = [ "vlc.desktop" ];
        "audio/basic" = [ "vlc.desktop" ];
        "audio/vnd.rn-realaudio" = [ "vlc.desktop" ];
        "audio/x-musepack" = [ "vlc.desktop" ];
        "audio/x-mpegurl" = [ "vlc.desktop" ];
        "audio/webm" = [ "vlc.desktop" ];
        "audio/AMR-WB" = [ "vlc.desktop" ];
        "audio/x-adpcm" = [ "vlc.desktop" ];
        "audio/x-gsm" = [ "vlc.desktop" ];
        "audio/x-xm" = [ "vlc.desktop" ];
        "audio/x-scpls" = [ "vlc.desktop" ];
        "audio/x-s3m" = [ "vlc.desktop" ];
        "audio/ac3" = [ "vlc.desktop" ];
        "audio/x-vorbis+ogg" = [ "vlc.desktop" ];
        "audio/x-ms-wma" = [ "vlc.desktop" ];
        "audio/x-tta" = [ "vlc.desktop" ];
        "audio/x-matroska" = [ "vlc.desktop" ];
        "audio/vnd.dts.hd" = [ "vlc.desktop" ];
        "audio/x-mod" = [ "vlc.desktop" ];
        "audio/mpeg" = [ "vlc.desktop" ];
        "audio/AMR" = [ "vlc.desktop" ];
        "audio/x-ms-asx" = [ "vlc.desktop" ];
        "application/vnd.mozilla.xul+xml" = [ "zen-beta.desktop" ];
        "application/xhtml+xml" = [ "zen-beta.desktop" ];
        "application/xspf+xml" = [ "zen-beta.desktop" ];
        "application/vnd.sun.xml.writer" = [ "org.pwmt.zathura.desktop" ];
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.sun.xml.writer.template" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/vnd.oasis.opendocument.text-master" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.slide" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/vnd.oasis.opendocument.text-template" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet-template" = [ "org.pwmt.zathura.desktop" ];
        "application/x-tar" = [ "org.pwmt.zathura.desktop" ];
        "application/x-7z-compressed" = [ "org.pwmt.zathura.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/vnd.sun.xml.impress.template" = [ "org.pwmt.zathura.desktop" ];
        "application/x-fictionbook+xml" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.template" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/zip" = [ "org.pwmt.zathura.desktop" ];
        "application/oxps" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/vnd.rar" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.oasis.opendocument.presentation" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.sun.xml.calc.template" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.sun.xml.writer.global" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.slideshow" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/vnd.oasis.opendocument.presentation-template" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.sun.xml.calc" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.sun.xml.impress" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.oasis.opendocument.text-web" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
          "org.pwmt.zathura.desktop"
        ];
        "application/x-shellscript" = [ "nvim.desktop" ];
      };
    };
  };
}
