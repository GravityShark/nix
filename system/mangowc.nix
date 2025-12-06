{ pkgs, ... }:

{

  # Ly display manager
  services.displayManager.ly = {
    enable = true;
    x11Support = false;
    settings = {
      animation = "colormix";
      battery_id = "BAT1";
      brightness_up_cmd = "${pkgs.brightnessctl}/bin/brightnessctl set -q -n +5%";
      brightness_down_cmd = "${pkgs.brightnessctl}/bin/brightnessctl set -q -n 5%-";
      # Session name to launch automatically
      # To find available session names, check the .desktop files in:
      #   - /usr/share/xsessions/ (for X11 sessions)
      #   - /usr/share/wayland-sessions/ (for Wayland sessions)
      # Use the filename without .desktop extension, or the value of DesktopNames field
      # Examples: "i3", "sway", "gnome", "plasma", "xfce"
      # If null, automatic login is disabled
      auto_login_session = "mango";

      # Username to automatically log in
      # Must be a valid user on the system
      # If null, automatic login is disabled
      auto_login_user = "gravity";

      deffault_input = "password";
    };
  };

  # GDM display manager
  # services.displayManager.gdm.enable = true;

  # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "gravity";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    brightnessctl
  ];
}
