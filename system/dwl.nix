{ pkgs, ... }:

let
  dwl-patched =
    (pkgs.dwl.override {
      configH = ./system/packages/dwl-conf-patches/config.h;
    }).overrideAttrs
      {
        patches = [
          ./system/packages/dwl-conf-patches/patches/bar/bar.patch
        ];
      };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      dwl = prev.dwl.overrideAttrs { patches = [ ]; };
    })
  ];

  environment.systemPackages = with pkgs; [
    dwl-patched
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    brightnessctl
  ];

  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      initial_session = {
        # Change "Hyprland" to the command to run your window manager. ^Note1
        command = "dwl";
        # Change "${user}" to your username or to your username variable.
        user = "gravity";
      };

      default_session = {
        # Change "Hyprland" to the command to run your window manager. ^Note1
        command = "dwl";
        # Change "${user}" to your username or to your username variable.
        user = "greeter";

      };
    };
  };
}
