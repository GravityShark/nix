# man `configuration.nix(5)` or `nixos-help`

{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Display server
  desktop.display-server = "niri";

  # System
  system = {
    intel.enable = true;
    msi.enable = true;
    nvidia.enable = true;
    openrazer.enable = true;
    vial.enable = true;
  };

  # Services
  service = {
    bluetooth.enable = true;
    disks.enable = true;
    kanata.enable = true;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    wayland-pipewire-idle-inhibit.enable = true;
    ydotool.enable = true;
    zerotierone.enable = true;
  };

  # Scripts tha
  update-scripts.enable = true;

  # `man configuration.nix` or https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "Asia/Manila"; # Set your time zone.
  time.hardwareClockInLocalTime = false; # allow it to work with windows time tbh

  # Use amurican localization so things don't break lol
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # environment shit
  environment = {
    shells = with pkgs; [
      bash
      mksh
    ];
  };

  # Long live the better posix shell
  users.defaultUserShell = pkgs.mksh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gravity = {
    isNormalUser = true;
    description = "gravity";
    extraGroups = [ "wheel" ];
  };

  # Use doas instead of sudo
  # https://www.reddit.com/r/NixOS/comments/rts8gm/sudo_or_doas/
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "gravity" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "ignore";
  };
}
