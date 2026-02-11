# man `configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  desktop.display-server = "mango";

  apps = {
    adb.enable = false;
    atk.enable = true;
    openrazer.enable = false;
    steam.enable = true;
    vial.enable = true;
    waydroid.enable = false;
  };

  system = {
    doas.enable = true;
    drag-click.enable = true;
    intel.enable = true;
    msi.enable = true;
    nvidia.enable = true;
    systemd-boot.enable = true;
    thp.enable = true;
    zram.enable = true;
  };

  service = {
    bluetooth.enable = true;
    disks.enable = true;
    distrobox.enable = false;
    flatpak.enable = false;
    gamemode.enable = false;
    kanata.enable = true;
    logind.enable = true;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    printing.enable = false;
    wayland-pipewire-idle-inhibit.enable = true;
  };

  # Helpful scripts for updating and maintaining the system
  update-scripts.enable = true;

  system.stateVersion = "25.11";

  ################################## Extra ###################################

  ## Cloudflare Warp for slow downloads
  # services.cloudflare-warp.enable = true;

  programs.ssh.startAgent = true;
}
