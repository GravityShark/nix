{ ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.gravity = {
    extraGroups = [
      "libvirtd"
    ];
  };
}
