# man `configuration.nix(5)` or `nixos-help`

{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Display server
  displayserver = "gnome";

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

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  # For somereason /dev/null is NOT being properly permissionisezed
  # system.activationScripts.chmod-dev-null.text = "chmod 777 /dev/null";

  # systemd.services."chmod" = {
  #   script = ''
  #     chmod 777 /dev/null
  #   '';
  #   wantedBy = [ "multi-user.target" ];
  # };
}
