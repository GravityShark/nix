{ lib, config, ... }:

# This is where generic systemd services should go, kinda like packages
{
  imports = [
    ./bluetooth.nix
    ./disks.nix
    ./kanata.nix
    ./networking.nix
    ./pipewire.nix
    ./power-management.nix
    ./printing.nix
    ./wayland-pipewire-idle-inhibit.nix
    ./ydotool.nix
    ./zerotierone.nix
  ];

  config = lib.mkIf (config.desktop.display-server == "gnome") {
    assertions = [
      {
        assertion = !(config.power-management.enable);
        message = "displayserver as \"gnome\" is incompatible with power-management.enable as true";
      }
      {
        assertion = !(config.wayland-pipewire-idle-inhibit.enable);
        message = "displayserver as \"gnome\" is incompatible with wayland-pipewire-idle-inhibit.enable as true";
      }
    ];
  };

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
