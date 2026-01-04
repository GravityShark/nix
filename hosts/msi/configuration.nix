# man `configuration.nix(5)` or `nixos-help`

{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Display server
  desktop.display-server = "niri";

  # System
  system = {
    doas.enable = true;
    intel.enable = true;
    msi.enable = true;
    nvidia.enable = true;
    # openrazer.enable = true;
    systemd-boot.enable = true;
    vial.enable = true;
  };

  # Services
  services.flatpak.enable = true;
  services.tailscale.enable = true;
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

  # `man configuration.nix` or https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}
