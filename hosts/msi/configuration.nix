# man `configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{ pkgs, config, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  desktop.display-server = "niri";

  system = {
    adb.enable = true;
    doas.enable = true;
    intel.enable = true;
    msi.enable = true;
    nvidia.enable = true;
    systemd-boot.enable = true;
    vial.enable = true;
  };

  service = {
    bluetooth.enable = true;
    disks.enable = true;
    kanata.enable = true;
    logind.enable = true;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    wayland-pipewire-idle-inhibit.enable = true;
  };

  # Helpful scripts for updating and maintaining the system
  update-scripts.enable = true;

  system.stateVersion = "25.11";

  ################################## Extra ###################################

  ## Currently only Roblox works with flatpak
  services.flatpak.enable = true;

  ## Cloudflare Warp for slow downloads
  services.cloudflare-warp.enable = true;

  ## Enable Drag clicking
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';

  ## Transparent Huge Page for Minecraft performance
  boot.kernelParams = [
    "transparent_hugepage=madvise"
    "transparent_hugepage_shmem=advise"
  ];

  ## WayDroid
  ## waydroid works with either default kernel, or nftables enabled
  ## You need to manually do everything in waydroid
  ## https://github.com/casualsnek/waydroid_script
  ## https://wiki.archlinux.org/title/Waydroid
  virtualisation.waydroid.enable = true;
  environment.systemPackages = with pkgs; [ waydroid-helper ];

  ## Steam
  ## https://github.com/YaLTeR/niri/issues/1034 steam fix
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  ## We are so Zen
  boot.kernelPackages = pkgs.linuxPackages_zen;

  ## NTSYnc
  boot.kernelModules = [ "ntsync" ];
}
