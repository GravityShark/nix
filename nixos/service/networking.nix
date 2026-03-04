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
      users.users.${config.username}.extraGroups = [ "networkmanager" ];
      # networking.proxy.default = "http://user:password@proxy:port/";
      # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      networking.networkmanager.enable = true;
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      networking.nftables.enable = true; # Better implementation
      networking.firewall.allowedTCPPorts = [ 25565 ];
      # networking.firewall.allowedUDPPorts = [ 19132 ];
      networking.firewall.enable = false;

      networking.timeServers = [
        "0.asia.pool.ntp.org"
        "1.asia.pool.ntp.org"
        "2.asia.pool.ntp.org"
        "3.asia.pool.ntp.org"
      ];

      networking.nameservers = [
        "9.9.9.9"
        "149.112.112.112"
        "2620:fe::fe"
        "2620:fe::9"
      ];

      networking.hosts = {
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

      networking.stevenblack = {
        enable = true;
        block = [
          "gambling"
          "porn"
        ];
      };
      # networking.extraHosts = ''
      #   ${builtins.readFile discord}
      #   ${builtins.readFile instagram}
      # '';
    };
}
