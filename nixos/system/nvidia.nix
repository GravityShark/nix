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

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.bleeding_edge;
      open = true;

      modesetting.enable = true;

      # https://wiki.archlinux.org/title/PRIME#NVIDIA
      # https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend
      moduleParams = {
        nvidia = {
          NVreg_EnableGpuFirmware = 0;
          NVreg_TemporaryFilePath = "/var/tmp";
        };
      };

      # dynamicBoost.enable = true;

      powerManagement = {
        # nvidia.NVreg_UseKernelSuspendNotifiers = 1
        # nvidia.NVreg_PreserveVideoMemoryAllocations = 1
        enable = true;
        # nvidia.NVreg_DynamicPowerManagement = "0x02"
        # feingrained also adds the udev rule
        finegrained = true;
      };

      prime = {
        intelBusId = "PCI:0@0:2:0";
        nvidiaBusId = "PCI:2@0:0:0";

        # reverseSync.enable = true;
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
    };
  };
}
