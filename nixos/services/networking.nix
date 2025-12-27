{
  lib,
  config,
  # pkgs,
  ...
}:

{
  options = {
    service.networking.enable = lib.mkEnableOption "enables networking";
  };
  config =
    # let
    #   discord = pkgs.fetchurl {
    #     name = "discord";
    #     url = "https://raw.githubusercontent.com/cyb3rko/social-media-hosts-blocklists/refs/heads/main/discordhosts.txt";
    #     sha256 = "8xvg3pie/0c9qrsdW0ezmARnmfyOM5+fGiwjzMpiRRQ=";
    #   };
    #   instagram = pkgs.fetchurl {
    #     name = "instagram";
    #     url = "https://raw.githubusercontent.com/cyb3rko/social-media-hosts-blocklists/refs/heads/main/instagramhosts.txt";
    #     sha256 = "21a7ffd6e67f2baf9da7221b4bf8e3374436a09a0603e678b8c0ae11845d26c8";
    #   };
    # in
    lib.mkIf config.service.networking.enable {

      # Configure network proxy if necessary
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
      # Enable networking
      networking.networkmanager.enable = true;
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # networking.timeServers = options.networking.timeServers.default ++ [ "asia.pool.ntp.org" ];
      networking.timeServers = [
        "0.asia.pool.ntp.org"
        "1.asia.pool.ntp.org"
        "2.asia.pool.ntp.org"
        "3.asia.pool.ntp.org"
      ];

      # boot.kernelPackages = pkgs.linuxPackages;
      #boot.kernelPackages = pkgs.linuxPackages_latest;
      # boot.kernelPackages = pkgs.linuxPackages_zen;

      # Hosts file
      networking = {
        hosts = {
          "192.168.0.3" = [ "clr" ];
          #   "0.0.0.0" = [
          #     "gdata.youtube.com"
          #     "googlevideo.com"
          #     "help.youtube.com"
          #     "img.youtube.com"
          #     "kids.youtube.com"
          #     "m.youtube.com"
          #     "redirector.googlevideo.com"
          #     "youtu.be"
          #     "youtube.com"
          #     "youtubei.googleapis.com"
          #     "youtube-nocookie.com"
          #     "ytimg.com"
          #     "ytimg-edge-static.l.google.com"
          #     "ytimg.l.google.com"
          #     "www.youtube.com"
          #     "www.googlevideo.com"
          #     "www.youtube-nocookie.com"
          #     "www.ytimg.com"
          #   ];
        };
        stevenblack = {
          enable = true;
          block = [
            "gambling"
            "porn"
          ];
        };
        # ${builtins.readFile discord}
        # extraHosts = ''
        #   ${builtins.readFile instagram}
        # '';
      };
    };
}
