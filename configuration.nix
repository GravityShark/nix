# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  inputs,
  pkgs,
  unstable,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix
    ./defaults.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = {
    firefox.enable = true;
    xwayland.enable = true;
    steam.enable = true;
  };

  environment.systemPackages = [
    pkgs.lshw
    pkgs.git
    pkgs.krita
    pkgs.nixfmt-rfc-style
    pkgs.libreoffice-fresh
    pkgs.vial
    unstable.mcontrolcenter
    unstable.neovim
    inputs.zen-browser.packages.x86_64-linux.specific
  ];
  environment.variables = {
    EDITOR = "nvim";
  };

  # enable doas, disable sudo
  # https://www.reddit.com/r/NixOS/comments/rts8gm/sudo_or_doas/
  security.doas.enable = true;
  security.sudo.enable = false;
  # Configure doas
  security.doas.extraRules = [
    {
      users = [ "gravity" ];
      keepEnv = true;
      persist = true;
    }
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # gettin flakey
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # https://discourse.nixos.org/t/mixing-stable-and-unstable-packages-on-flake-based-nixos-system/50351/4
  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.unstable = import inputs.unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };
}
