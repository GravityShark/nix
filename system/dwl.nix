{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      dwl = prev.dwl.overrideAttrs { patches = [ ./packages/dwl-conf-patches/ ]; };
    })
  ];

  environment.systemPackages = with pkgs; [
    dwl
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
