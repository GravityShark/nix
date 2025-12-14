{ ... }:

{
  # Power
  services.fstrim.enable = true;
  services.thermald.enable = true; # test this later
  services.tuned.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;

  # Vial udev rule
  # https://get.vial.today/manual/linux-udev.html
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # systemd.timers."background" = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnBootSec = "10m";
  #     OnUnitActiveSec = "100m";
  #     User = "gravity";
  #     Unit = "hello-world.service";
  #   };
  # };

  # systemd.services."background" = {
  #   script = ''$HOME/.scripts/random_background'';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "gravity";
  #   };
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # Doesn't work, needs https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/1192, to be pushed
  # services.libinput = {
  #   enable = true;
  #   mouse = {
  #     scrollMethod = "button";
  #     scrollButton = 274;
  #   };
  # };
  # environment.systemPackages = with pkgs; [
  #   libinput
  #   libinput.dev
  # ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
}
