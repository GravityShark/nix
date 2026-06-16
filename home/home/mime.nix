{
  config,
  lib,
  ...
}:

{
  options = {
    mime.enable = lib.mkEnableOption "enables mime";
  };
  config = lib.mkIf config.mime.enable {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "org.gnome.Nautilus.desktop" ];

        "application/vnd.oasis.opendocument.text-master" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.oasis.opendocument.text-web" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.slide" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        "application/vnd.sun.xml.calc.template" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.sun.xml.impress.template" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.sun.xml.writer.global" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];
        "audio/AMR" = [ "mpv.desktop" ];
        "audio/AMR-WB" = [ "mpv.desktop" ];
        "audio/aac" = [ "mpv.desktop" ];
        "audio/ac3" = [ "mpv.desktop" ];
        "audio/basic" = [ "mpv.desktop" ];
        "audio/flac" = [ "mpv.desktop" ];
        "audio/midi" = [ "mpv.desktop" ];
        "audio/mp2" = [ "mpv.desktop" ];
        "audio/mp4" = [ "mpv.desktop" ];
        "audio/mpeg" = [ "mpv.desktop" ];
        "audio/ogg" = [ "mpv.desktop" ];
        "audio/vnd.dts" = [ "mpv.desktop" ];
        "audio/vnd.dts.hd" = [ "mpv.desktop" ];
        "audio/vnd.rn-realaudio" = [ "mpv.desktop" ];
        "audio/vnd.wave" = [ "mpv.desktop" ];
        "audio/webm" = [ "mpv.desktop" ];
        "audio/x-adpcm" = [ "mpv.desktop" ];
        "audio/x-aiff" = [ "mpv.desktop" ];
        "audio/x-ape" = [ "mpv.desktop" ];
        "audio/x-gsm" = [ "mpv.desktop" ];
        "audio/x-it" = [ "mpv.desktop" ];
        "audio/x-matroska" = [ "mpv.desktop" ];
        "audio/x-mod" = [ "mpv.desktop" ];
        "audio/x-mpegurl" = [ "mpv.desktop" ];
        "audio/x-ms-asx" = [ "mpv.desktop" ];
        "audio/x-ms-wma" = [ "mpv.desktop" ];
        "audio/x-musepack" = [ "mpv.desktop" ];
        "audio/x-s3m" = [ "mpv.desktop" ];
        "audio/x-scpls" = [ "mpv.desktop" ];
        "audio/x-speex" = [ "mpv.desktop" ];
        "audio/x-tta" = [ "mpv.desktop" ];
        "audio/x-vorbis+ogg" = [ "mpv.desktop" ];
        "audio/x-wavpack" = [ "mpv.desktop" ];
        "audio/x-xm" = [ "mpv.desktop" ];
        "image/jp2" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        "image/openraster" = [ "org.pwmt.zathura.desktop" ];
        "image/vnd.microsoft.icon" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        "image/vnd.zbrush.pcx" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        "image/x-eps" = [ "org.pwmt.zathura.desktop" ];
        "text/spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ];
        "x-content/audio-cdda" = [ "mpv.desktop" ];
        "x-content/audio-player" = [ "mpv.desktop" ];
        "x-content/video-dvd" = [ "mpv.desktop" ];
        "x-content/video-svcd" = [ "mpv.desktop" ];
        "x-content/video-vcd" = [ "mpv.desktop" ];
        "application/x-tar" = [ "org.pwmt.zathura.desktop" ];
        "application/x-mobipocket-ebook" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.rar" = [ "org.pwmt.zathura.desktop" ];
        "application/x-7z-compressed" = [ "org.pwmt.zathura.desktop" ];
        "application/x-modrinth-modpack+zip" = [ "org.prismlauncher.PrismLauncher.desktop" ];
        "application/x-shellscript" = [ "nvim.desktop" ];
        "image/vnd.djvu" = [ "onlyoffice-desktopeditors.desktop" ];
        "image/vnd.djvu+multipage" = [ "onlyoffice-desktopeditors.desktop" ];
        "image/x-portable-anymap" = [ "swayimg.desktop" ];
        "image/bmp" = [ "swayimg.desktop" ];
        "image/jxl" = [ "swayimg.desktop" ];
        "image/webp" = [ "swayimg.desktop" ];
        "image/heif" = [ "swayimg.desktop" ];
        "image/x-portable-pixmap" = [ "swayimg.desktop" ];
        "image/x-portable-graymap" = [ "swayimg.desktop" ];
        "image/avif" = [ "swayimg.desktop" ];
        "image/svg+xml" = [ "swayimg.desktop" ];
        "image/x-tga" = [ "swayimg.desktop" ];
        "image/x-exr" = [ "swayimg.desktop" ];
        "image/jpeg" = [ "swayimg.desktop" ];
        "image/png" = [ "swayimg.desktop" ];
        "image/gif" = [ "swayimg.desktop" ];
        "image/x-portable-bitmap" = [ "swayimg.desktop" ];
        "image/tiff" = [ "swayimg.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "text/x-chdr" = [ "nvim.desktop" ];
        "text/x-makefile" = [ "nvim.desktop" ];
        "text/x-c++src" = [ "nvim.desktop" ];
        "text/x-csrc" = [ "nvim.desktop" ];
        "video/mpeg" = [ "mpv.desktop" ];
        "video/x-ogm+ogg" = [ "mpv.desktop" ];
        "video/x-theora+ogg" = [ "mpv.desktop" ];
        "video/ogg" = [ "mpv.desktop" ];
        "video/x-anim" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/x-nsv" = [ "mpv.desktop" ];
        "video/vnd.avi" = [ "mpv.desktop" ];
        "video/mp4" = [ "mpv.desktop" ];
        "video/vnd.rn-realvideo" = [ "mpv.desktop" ];
        "video/vnd.mpegurl" = [ "mpv.desktop" ];
        "video/3gpp2" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/mp2t" = [ "mpv.desktop" ];
        "video/x-flv" = [ "mpv.desktop" ];
        "video/x-flic" = [ "mpv.desktop" ];
        "video/dv" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];

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
        "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
        "x-scheme-handler/https" = [ "zen-beta.desktop" ];
        "x-scheme-handler/http" = [ "zen-beta.desktop" ];
        "x-scheme-handler/about" = [ "zen-beta.desktop" ];
        "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
        # "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
        # "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];

        # "application/x-bittorrent" = [ "org.qbittorrent.qBittorrent.desktop" ];
        # "x-content/video-dvd" = [ "mpv.desktop" ];
        # "x-content/video-svcd" = [ "mpv.desktop" ];
        # "x-content/audio-player" = [ "mpv.desktop" ];
        # "x-content/audio-cdda" = [ "mpv.desktop" ];
        # "x-content/video-vcd" = [ "mpv.desktop" ];
        # "video/mp4" = [ "mpv.desktop" ];
        # "video/x-ms-wmv" = [ "mpv.desktop" ];
        # "video/dv" = [ "mpv.desktop" ];
        # "video/3gpp" = [ "mpv.desktop" ];
        # "video/x-matroska" = [ "mpv.desktop" ];
        # "video/x-nsv" = [ "mpv.desktop" ];
        # "video/vnd.rn-realvideo" = [ "mpv.desktop" ];
        # "video/x-flic" = [ "mpv.desktop" ];
        # "video/3gpp2" = [ "mpv.desktop" ];
        # "video/vnd.mpegurl" = [ "mpv.desktop" ];
        # "video/vnd.avi" = [ "mpv.desktop" ];
        # "video/webm" = [ "mpv.desktop" ];
        # "video/mp2t" = [ "mpv.desktop" ];
        # "video/x-theora+ogg" = [ "mpv.desktop" ];
        # "video/x-ogm+ogg" = [ "mpv.desktop" ];
        # "video/x-flv" = [ "mpv.desktop" ];
        # "video/quicktime" = [ "mpv.desktop" ];
        # "video/ogg" = [ "mpv.desktop" ];
        # "video/x-anim" = [ "mpv.desktop" ];
        # "video/mpeg" = [ "mpv.desktop" ];
        "text/x-c++hdr" = [ "nvim.desktop" ];
        # "text/x-makefile" = [ "nvim.desktop" ];
        "text/vbscript" = [ "nvim.desktop" ];
        "text/tcl" = [ "nvim.desktop" ];
        "text/x-tex" = [ "nvim.desktop" ];
        "text/x-java" = [ "nvim.desktop" ];
        # "text/x-chdr" = [ "nvim.desktop" ];
        # "text/x-c++src" = [ "nvim.desktop" ];
        "text/x-moc" = [ "nvim.desktop" ];
        "text/x-pascal" = [ "nvim.desktop" ];
        # "text/x-csrc" = [ "nvim.desktop" ];
        # "text/plain" = [ "nvim.desktop" ];
        "text/csv" = [ "onlyoffice-desktopeditors.desktop" ];
        # "text/spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ];
        "text/tab-separated-values" = [ "onlyoffice-desktopeditors.desktop" ];
        "text/x-google-video-pointer" = [ "mpv.desktop" ];
        "text/html" = [ "zen-beta.desktop" ];
        # "image/vnd.zbrush.pcx" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        # "image/jp2" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        # "image/vnd.microsoft.icon" = [ "com.github.jeromerobert.pdfarranger.desktop" ];
        # "image/avif" = [ "swayimg.desktop" ];
        # "image/x-portable-bitmap" = [ "swayimg.desktop" ];
        # "image/png" = [ "swayimg.desktop" ];
        # "image/gif" = [ "swayimg.desktop" ];
        # "image/jpeg" = [ "swayimg.desktop" ];
        # "image/x-portable-anymap" = [ "swayimg.desktop" ];
        # "image/svg+xml" = [ "swayimg.desktop" ];
        # "image/tiff" = [ "swayimg.desktop" ];
        # "image/bmp" = [ "swayimg.desktop" ];
        # "image/jxl" = [ "swayimg.desktop" ];
        # "image/x-tga" = [ "swayimg.desktop" ];
        # "image/x-exr" = [ "swayimg.desktop" ];
        # "image/x-portable-pixmap" = [ "swayimg.desktop" ];
        # "image/x-portable-graymap" = [ "swayimg.desktop" ];
        # "image/webp" = [ "swayimg.desktop" ];
        # "image/heif" = [ "swayimg.desktop" ];
        # "image/x-eps" = [ "org.pwmt.zathura.desktop" ];
        # "image/vnd.djvu+multipage" = [ "org.pwmt.zathura.desktop" ];
        # "image/vnd.djvu" = [ "org.pwmt.zathura.desktop" ];
        # "image/openraster" = [ "org.pwmt.zathura.desktop" ];
        # "audio/x-ape" = [ "mpv.desktop" ];
        # "audio/ogg" = [ "mpv.desktop" ];
        # "audio/x-aiff" = [ "mpv.desktop" ];
        # "audio/x-wavpack" = [ "mpv.desktop" ];
        # "audio/vnd.dts" = [ "mpv.desktop" ];
        # "audio/x-it" = [ "mpv.desktop" ];
        # "audio/mp2" = [ "mpv.desktop" ];
        # "audio/mp4" = [ "mpv.desktop" ];
        # "audio/x-speex" = [ "mpv.desktop" ];
        # "audio/vnd.wave" = [ "mpv.desktop" ];
        # "audio/aac" = [ "mpv.desktop" ];
        # "audio/midi" = [ "mpv.desktop" ];
        # "audio/flac" = [ "mpv.desktop" ];
        # "audio/basic" = [ "mpv.desktop" ];
        # "audio/vnd.rn-realaudio" = [ "mpv.desktop" ];
        # "audio/x-musepack" = [ "mpv.desktop" ];
        # "audio/x-mpegurl" = [ "mpv.desktop" ];
        # "audio/webm" = [ "mpv.desktop" ];
        # "audio/AMR-WB" = [ "mpv.desktop" ];
        # "audio/x-adpcm" = [ "mpv.desktop" ];
        # "audio/x-gsm" = [ "mpv.desktop" ];
        # "audio/x-xm" = [ "mpv.desktop" ];
        # "audio/x-scpls" = [ "mpv.desktop" ];
        # "audio/x-s3m" = [ "mpv.desktop" ];
        # "audio/ac3" = [ "mpv.desktop" ];
        # "audio/x-vorbis+ogg" = [ "mpv.desktop" ];
        # "audio/x-ms-wma" = [ "mpv.desktop" ];
        # "audio/x-tta" = [ "mpv.desktop" ];
        # "audio/x-matroska" = [ "mpv.desktop" ];
        # "audio/vnd.dts.hd" = [ "mpv.desktop" ];
        # "audio/x-mod" = [ "mpv.desktop" ];
        # "audio/mpeg" = [ "mpv.desktop" ];
        # "audio/AMR" = [ "mpv.desktop" ];
        # "audio/x-ms-asx" = [ "mpv.desktop" ];
        "application/vnd.mozilla.xul+xml" = [ "zen-beta.desktop" ];
        "application/xhtml+xml" = [ "zen-beta.desktop" ];
        "application/xspf+xml" = [ "zen-beta.desktop" ];
        "application/vnd.sun.xml.writer" = [ "org.pwmt.zathura.desktop" ];
        "application/epub+zip" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.sun.xml.writer.template" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.template" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        # "application/vnd.oasis.opendocument.text-master" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.oasis.opendocument.text" = [ "onlyoffice-desktopeditors.desktop" ];
        # "application/vnd.openxmlformats-officedocument.presentationml.slide" = [
        #   "onlyoffice-desktopeditors.desktop"
        # ];
        "application/vnd.oasis.opendocument.text-template" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet-template" = [ "onlyoffice-desktopeditors.desktop" ];
        # "application/x-tar" = [ "org.pwmt.zathura.desktop" ];
        # "application/x-7z-compressed" = [ "org.pwmt.zathura.desktop" ];
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.template" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        # "application/vnd.sun.xml.impress.template" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/x-fictionbook+xml" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.oasis.opendocument.spreadsheet" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.template" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        # "application/zip" = [ "org.pwmt.zathura.desktop" ];
        # "application/oxps" = [ "org.pwmt.zathura.desktop" ];
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        # "application/vnd.rar" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.oasis.opendocument.presentation" = [ "onlyoffice-desktopeditors.desktop" ];
        # "application/vnd.sun.xml.calc.template" = [ "onlyoffice-desktopeditors.desktop" ];
        # "application/vnd.sun.xml.writer.global" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.openxmlformats-officedocument.presentationml.slideshow" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        "application/vnd.oasis.opendocument.presentation-template" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        "application/vnd.sun.xml.calc" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.sun.xml.impress" = [ "onlyoffice-desktopeditors.desktop" ];
        # "application/vnd.oasis.opendocument.text-web" = [ "onlyoffice-desktopeditors.desktop" ];
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
          "onlyoffice-desktopeditors.desktop"
        ];
        # "application/x-shellscript" = [ "nvim.desktop" ];
      };
    };
  };
}
