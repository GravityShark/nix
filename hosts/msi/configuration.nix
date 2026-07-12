# man `configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  desktop = {
    display-server = "niri";
    login-manager = "greetd";
  };

  apps = {
    adb.enable = false;
    atk.enable = true;
    distrobox.enable = false;
    gamemode.enable = false;
    gpu-screen-recorder.enable = true;
    openrazer.enable = false;
    steam.enable = true;
    vial.enable = true;
    waydroid.enable = false;
    winboat.enable = false; # FIX: Winboat fails to compile for somereason
  };

  system = {
    doas.enable = true;
    drag-click.enable = true;
    intel.enable = true;
    # lanzaboote.enable = true;
    msi.enable = true;
    nvidia.enable = true;
    systemd-boot.enable = true;
    thp.enable = true;
    zram.enable = true;
  };

  service = {
    bluetooth.enable = true;
    disks.enable = true;
    flatpak.enable = true;
    kanata.enable = true;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    printing.enable = true;
    wayland-pipewire-idle-inhibit.enable = true;
  };

  # Helpful scripts for updating and maintaining the system
  update-scripts.enable = true;

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";

  ################################## Extra ###################################

  ## Cloudflare Warp for slow downloads
  services.cloudflare-warp.enable = true;
  # programs.kdeconnect.enable = true;
}
