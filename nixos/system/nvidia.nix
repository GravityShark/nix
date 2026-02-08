{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    system.nvidia.enable = lib.mkEnableOption "enables nvidia";
  };
  config = lib.mkIf config.system.nvidia.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    services.xserver.videoDrivers = [
      "nvidia"
      "modesetting"
    ];

    # https://wiki.archlinux.org/title/PRIME#NVIDIA
    # https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend
    boot.extraModprobeConfig = ''
      options nvidia "NVreg_EnableGpuFirmware=0"
    '';

    hardware.nvidia = {
      # Open drivers prevent going into D3
      # https://bbs.archlinux.org/viewtopic.php?pid=2187680#p2187680
      open = true;

      nvidiaPersistenced = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };

      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:2:0:0";

        reverseSync.enable = true;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
