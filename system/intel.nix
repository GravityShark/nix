{ pkgs, ... }:

{
  boot.initrd.kernelModules = [ "i915" ];
  boot.kernelParams = [ "i915.enable_guc=2" ];
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
    # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # VA-API (iHD) userspace
      intel-compute-runtime # OpenCL (NEO) + Level Zero for Arc/Xe
      vpl-gpu-rt
      # intel-compute-runtime-legacy1
      intel-compute-runtime
      # NOTE: 'intel-ocl' also exists as a legacy package; not recommended for Arc/Xe.
      # libvdpau-va-gl       # Only if you must run VDPAU-only apps
    ];
  };
  hardware.enableRedistributableFirmware = true;
  services.xserver.videoDrivers = [ "modesetting" ];
}
