{ pkgs, ... }:
let
  patches = builtins.fetchGit {
    url = "https://github.com/GravityShark/dwl-conf-patches";
    rev = "506f5b12eb12dadd7e8327012d30596baeb1560d";
  };
in
{
  nixpkgs.overlays = [
    (final: prev: { dwl = prev.dwl.override { configH = patches + "/config.h"; }; })
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
