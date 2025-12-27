# man `configuration.nix(5)` or `nixos-help`

{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Display server
  displayserver = "niri";

  # System
  intel.enable = true;
  msi.enable = true;
  nvidia.enable = true;
  openrazer.enable = true;
  vial.enable = true;

  # Services
  bluetooth.enable = true;
  disks.enable = true;
  kanata.enable = true;
  networking.enable = true;
  pipewire.enable = true;
  power-management.enable = true;
  scripts.enable = true;
  wayland-pipewire-idle-inhibit.enable = true;
  ydotool.enable = true;
  zerotierone.enable = true;

  # `man configuration.nix` or https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}
