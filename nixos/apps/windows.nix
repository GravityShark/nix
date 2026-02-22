{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.windows.enable = lib.mkEnableOption "enables windows";
  };
  config = lib.mkIf config.apps.windows.enable {
    # Set up virtualisation
    virtualisation.libvirtd = {
      enable = true;

      # Enable TPM emulation (for Windows 11)
      qemu = {
        swtpm.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };

    # Enable USB redirection
    virtualisation.spiceUSBRedirection.enable = true;

    # Allow VM management
    users.groups.libvirtd.members = [ config.username ];
    users.groups.kvm.members = [ config.username ];

    # Enable VM networking and file sharing
    environment.systemPackages = with pkgs; [
      dnsmasq # VM networking
      phodav # (optional) Share files with guest VMs
    ];
  };
}
