{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./desktop
    ./service
    ./system
    ./update-scripts.nix
  ];

  options.username = lib.mkOption {
    type = lib.types.str;
    description = "the main singular user that is going to be used";
  };

  config = {

    nixpkgs.config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "cloudflare-warp"
        "nvidia-persistenced"
        "nvidia-settings"
        "nvidia-x11"
        "steam"
        "steam-unwrapped"
        # "zerotierone"
      ];

    services.dbus.implementation = "broker";

    time.timeZone = lib.mkDefault "Asia/Manila"; # Set your time zone.

    # environment shit
    environment = {
      shells = with pkgs; [
        bash
        dash
      ];
      binsh = lib.mkForce "${pkgs.dash}/bin/dash";
      sessionVariables.ENV = lib.mkDefault "$HOME/.shinit";
    };

    # W shell
    users.defaultUserShell = lib.mkOverride 999 pkgs.dash;

    networking.hostName = lib.mkDefault "nixos"; # Define your hostname.

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${config.username} = {
      isNormalUser = true;
      description = config.username;
      extraGroups = [ "wheel" ];
    };

    # Use amurican localization so things don't break lol
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
    i18n.extraLocaleSettings = lib.mkDefault {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    nix.settings.download-buffer-size = 500000000;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nix.settings.extra-substituters = [ "https://nix-community.cachix.org" ];
    nix.settings.extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
