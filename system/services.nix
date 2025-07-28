{ ... }:

{
  # GnuPG
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Vial udev rule
  # https://get.vial.today/manual/linux-udev.html
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  systemd.services."chmod" = {
    script = ''
      chmod 777 /dev/null
    '';
    wantedBy = [ "multi-user.target" ];
  };

  # systemd.timers."background" = {
  #   wantedBy = [ "timers.target" ];
  #   timerConfig = {
  #     OnBootSec = "10m";
  #     OnUnitActiveSec = "100m";
  #     User = "gravity";
  #     Unit = "hello-world.service";
  #   };
  # };

  # systemd.services."background" = {
  #   script = ''$HOME/.scripts/random_background'';
  #   serviceConfig = {
  #     Type = "oneshot";
  #     User = "gravity";
  #   };
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # Doesn't work, needs https://gitlab.freedesktop.org/libinput/libinput/-/merge_requests/1192, to be pushed
  # services.libinput = {
  #   enable = true;
  #   mouse = {
  #     scrollMethod = "button";
  #     scrollButton = 274;
  #   };
  # };
  # environment.systemPackages = with pkgs; [
  #   libinput
  #   libinput.dev
  # ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };
}
