{ pkgs, ... }:

let
  discord = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/cyb3rko/social-media-hosts-blocklists/refs/heads/main/discordhosts.txt";
    sha256 = "8xvg3pie/0c9qrsdW0ezmARnmfyOM5+fGiwjzMpiRRQ=";
  };
in
{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gravity = {
    isNormalUser = true;
    description = "gravity";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

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

  # allow it to work with windows time tbh
  time.hardwareClockInLocalTime = false;

  # networking.timeServers = options.networking.timeServers.default ++ [ "asia.pool.ntp.org" ];
  networking.timeServers = [
    "0.asia.pool.ntp.org"
    "1.asia.pool.ntp.org"
    "2.asia.pool.ntp.org"
    "3.asia.pool.ntp.org"
  ];

  # use xanmod kernel kuh
  # boot.kernelPackages = pkgs.linuxPackages_xanmod;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.kernelModules = [ "v4l2loopback" ];
  # boot.extraModulePackages = [ pkgs.linuxPackages_xanmod_latest.v4l2loopback ];

  # Hosts file
  networking = {
    hosts = {
      "192.168.0.3" = [ "clr" ];
      "0.0.0.0" = [
        "gdata.youtube.com"
        "googlevideo.com"
        "help.youtube.com"
        "img.youtube.com"
        "kids.youtube.com"
        "m.youtube.com"
        "redirector.googlevideo.com"
        "youtu.be"
        "youtube.com"
        # "youtube.googleapis.com"
        "youtubei.googleapis.com"
        "youtube-nocookie.com"
        "ytimg.com"
        "ytimg-edge-static.l.google.com"
        "ytimg.l.google.com"
        "www.youtube.com"
        "www.googlevideo.com"
        "www.youtube-nocookie.com"
        "www.ytimg.com"
      ];
    };
    stevenblack = {
      enable = true;
      block = [
        "gambling"
        "porn"
      ];
    };
    # extraHosts = ''${builtins.readFile discord} '';
  };
}
