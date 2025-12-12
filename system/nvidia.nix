{
  config,
  pkgs,
  ...
}:

# "${
#   builtins.fetchGit {
#     url = "https://github.com/NixOS/nixos-hardware.git";
#     rev = "7d9552ef6b02da7b8fafe426c0db5358ab8c4009";
#   }
# }/msi/gl65/10SDR-492"
# ./nvidia2.nix
#
# hardware.nvidia.prime = {
#   intelBusId = lib.mkForce "PCI:0:2:0";
#   nvidiaBusId = lib.mkForce "PCI:2:0:0";
#
#   sync = true;
# };

{
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
  };

  services.xserver.videoDrivers = [
    "nvidia"
    "modesetting"
  ];

  # services.tlp.settings = {
  #   sound_power_save_on_ac = 1;
  #   sound_power_save_on_bat = 1;
  #   runtime_pm_enable = "02:00.0";
  # };

  # https://wiki.archlinux.org/title/PRIME#NVIDIA
  # https://wiki.archlinux.org/title/NVIDIA/Tips_and_tricks#Preserve_video_memory_after_suspend
  services.udev.extraRules = ''
    # Enable runtime PM for NVIDIA VGA/3D controller devices on driver bind
    ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
    ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"

    # Disable runtime PM for NVIDIA VGA/3D controller devices on driver unbind
    ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
    ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"

    # Enable runtime PM for NVIDIA VGA/3D controller devices on adding device
    # ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
    # ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
  '';
  # systemd.tmpfiles.rules = [ "w /sys/bus/pci/devices/0000:02:00.0/power/control - - - - auto" ];

  boot.extraModprobeConfig = ''
    options nvidia "NVreg_DynamicPowerManagement=0x02"
    options nvidia "NVreg_EnableGpuFirmware=0"
  '';
  # This actually breaks suspend
  # options nvidia "NVreg_PreserveVideoMemoryAllocations=1"
  hardware.nvidia = {
    nvidiaPersistenced = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # NOOOO
    # https://bbs.archlinux.org/viewtopic.php?pid=2187680#p2187680
    open = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";

      # sync.enable = true;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
}
