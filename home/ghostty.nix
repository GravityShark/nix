{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
      cursor-style = "block";
      font-family = "Aporetic Sans Mono";
      font-size = 11;
      gtk-single-instance = true;
      gtk-titlebar = false;
      shell-integration-features = "no-cursor";
      theme = "Gruvbox Material Light";
      window-decoration = "none";
    };
  };

  systemd.user.services.ghostty = {
    Unit = {
      Description = "Ghostty";
      After = [
        "graphical-session.target"
        "dbus.socket"
      ];
      Requires = [ "dbus.socket" ];
    };
    Service = {
      Type = "notify-reload";
      ReloadSignal = "SIGUSR2";
      BusName = "com.mitchellh.ghostty";
      ExecStart = "${pkgs.ghostty}/bin/ghostty --gtk-single-instance=true --initial-window=false";
    };
    Install.WantedBy = [ "graphical-session.target" ];
  };
  home.file.".config/ghostty".source = dump/.config/ghostty;
}
