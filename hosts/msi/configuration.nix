# man `configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  desktop.display-server = "niri";
  desktop.login-manager = "greetd";

  apps = {
    adb.enable = false;
    atk.enable = true;
    openrazer.enable = false;
    steam.enable = true;
    vial.enable = true;
    waydroid.enable = true;
  };

  system = {
    doas.enable = true;
    drag-click.enable = true;
    intel.enable = true;
    msi.enable = true;
    nvidia.enable = true;
    systemd-boot.enable = true;
    thp.enable = true;
    zram.enable = false;
  };

  service = {
    bluetooth.enable = true;
    disks.enable = true;
    distrobox.enable = false;
    flatpak.enable = true;
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

  ## Use labwc instead when we are gaming cause it has tearing support
  ## we gotta wait for this https://github.com/niri-wm/niri/issues/844
  # programs.labwc.enable = true;

  # programs.nix-ld = {
  #   enable = true;
  # libraries = with pkgs; [
  #   ## Put here any library that is required when running a package
  #   ## ...
  #   ## Uncomment if you want to use the libraries provided by default in the steam distribution
  #   ## but this is quite far from being exhaustive
  #   ## https://github.com/NixOS/nixpkgs/issues/354513
  #   # (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
  # ];
  # };

  # environment.systemPackages = with pkgs; [
  #   gparted
  #   gst_all_1.gst-plugins-good
  #   gst_all_1.gst-plugins-base
  #   gst_all_1.gstreamer
  #   libmpg123
  # ];
}
