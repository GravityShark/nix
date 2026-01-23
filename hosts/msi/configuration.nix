# man `configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  desktop.display-server = "niri";

  system = {
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
  # services.cloudflare-warp.enable = true;

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
  virtualization.waydroid.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [ steam-tui ];
  #   # WINE
  #   wine
  #   winetricks
  #   protontricks
  #   vulkan-tools
  #
  #   # Lutris
  #   #lutris-unwrapped  # (not needed)
  #   lutris
  #
  #   # Extra dependencies
  #   # https://github.com/lutris/docs/
  #   gnutls
  #   openldap
  #   freetype
  #   sqlite
  #   libxml2
  #   xml2
  #   SDL2
  # ];

  ## Nix-ld for jc
  # programs.nix-ld = {
  #   enable = true;
  #   libraries = with pkgs; [
  #     bubblewrap
  #     dwarfs
  #     fuse-overlayfs
  #     wineWowPackages.staging
  #   ];
  # };

  # We are so Zen
  boot.kernelPackages = pkgs.linuxPackages_zen;
}
