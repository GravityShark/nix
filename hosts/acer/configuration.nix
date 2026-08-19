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
    atk.enable = false;
    distrobox.enable = false;
    gamemode.enable = false;
    gpu-screen-recorder.enable = false;
    openrazer.enable = false;
    steam.enable = false;
    vial.enable = true;
    waydroid.enable = false;
    winboat.enable = false; # FIX: Winboat fails to compile for somereason
  };

  system = {
    doas.enable = true;
    drag-click.enable = true;
    intel.enable = true;
    # lanzaboote.enable = true;
    msi.enable = false;
    nvidia.enable = false;
    systemd-boot.enable = true;
    thp.enable = true;
    zram.enable = false;
  };

  service = {
    bluetooth.enable = true;
    disks.enable = true;
    flatpak.enable = false;
    kanata.enable = true;
    llama-cpp.enable = false;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    printing.enable = true;
    wayland-pipewire-idle-inhibit.enable = true;
  };

  # Helpful scripts for updating and maintaining the system
  update-scripts.enable = true;

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "26.05";

  ################################## Extra ###################################

  ## Cloudflare Warp for slow downloads
  services.cloudflare-warp.enable = true;
  # programs.kdeconnect.enable = true;

  programs.nix-ld.enable = true;
}
