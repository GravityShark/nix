{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    # clearDefaultKeybinds = true;
    enableFishIntegration = true;
    package = pkgs.ghostty;
    settings = {
      # command = "${pkgs.fish}/bin/fish --login --interactive";
      confirm-close-surface = false;
      cursor-style = "block";
      font-family = "Aporetic Sans Mono";
      font-size = 11;
      gtk-single-instance = true;
      gtk-titlebar = false;
      quit-after-last-window-closed = false;
      shell-integration-features = "no-cursor";
      shell-integration = "fish";
      theme = "Gruvbox Material Light";
      window-decoration = "none";
    };
    systemd.enable = true;
  };

  #lib.mkForce {

  # PartOf = [ "graphical-session.target" ];

  # Environment = [
  #   "DISPLAY=%{DISPLAY}"
  #   "WAYLAND_DISPLAY=%{WAYLAND_DISPLAY}"
  #   "XDG_RUNTIME_DIR=%t"
  #   "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
  # ];

  # Good practice for GUI apps under systemd
  # Restart = "on-failure";
  # };
  # systemd.user.services.ghostty = {
  #   Unit = {
  #     Description = "Ghostty";
  #     After = [
  #       "graphical-session.target"
  #       "dbus.socket"
  #     ];
  #     PartOf = [ "graphical-session.target" ];
  #     Requires = [ "dbus.socket" ];
  #   };
  #   Service = {
  #     Type = "notify-reload";
  #     ReloadSignal = "SIGUSR2";
  #     BusName = "com.mitchellh.ghostty";
  #     ExecStart = "${pkgs.ghostty}/bin/ghostty --gtk-single-instance=true --initial-window=false";
  #
  #   };
  #   Install.WantedBy = [ "graphical-session.target" ];
  # };
}
