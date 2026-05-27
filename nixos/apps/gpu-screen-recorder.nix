{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.gpu-screen-recorder.enable = lib.mkEnableOption "enables gpu-screen-recorder";
  };
  config = lib.mkIf config.apps.gpu-screen-recorder.enable {
    environment.systemPackages = [ pkgs.gpu-screen-recorder-gtk ];
    programs.gpu-screen-recorder = {
      enable = true;
      # package = (
      #   pkgs.symlinkJoin {
      #     name = "gpu-screen-recorder";
      #     buildInputs = [ pkgs.makeWrapper ];
      #     paths = [ pkgs.gpu-screen-recorder ];
      #     postBuild = ''
      #       wrapProgram $out/bin/gpu-screen-recorder \
      #         --set __NV_PRIME_RENDER_OFFLOAD 1 \
      #         --set __NV_PRIME_RENDER_OFFLOAD_PROVIDER NVIDIA-G0 \
      #         --set __GLX_VENDOR_LIBRARY_NAME nvidia \
      #         --set __VK_LAYER_NV_optimus NVIDIA_only
      #     '';
      #   }
      # );
    };
  };
}
