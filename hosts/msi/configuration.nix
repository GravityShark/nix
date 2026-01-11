# man `configuration.nix(5)` or `nixos-help` or https://nixos.org/nixos/options.html).

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
    systemd-boot.enable = true;
    vial.enable = true;
  };

  # Services
  service = {
    bluetooth.enable = true;
    disks.enable = true;
    gamemode.enable = true;
    kanata.enable = true;
    logind.enable = true;
    networking.enable = true;
    pipewire.enable = true;
    power-management.enable = true;
    wayland-pipewire-idle-inhibit.enable = true;
  };

  # Helpful scripts for updating and maintaining the system
  update-scripts.enable = true;

  ################################## Extra ###################################
  # Currently only Roblox works with flatpak
  # services.flatpak.enable = true;

  # Enable Drag clicking
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Never Debounce]
    MatchUdevType=mouse
    ModelBouncingKeys=1
  '';

  system.stateVersion = "25.11";
}
