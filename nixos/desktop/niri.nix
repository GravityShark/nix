{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  config = lib.mkIf (config.desktop.display-server == "niri") {

    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    environment.systemPackages = with pkgs; [
      git # FIX: I have no clue why sodiboo/niri needs git like this
      xwayland-satellite
    ];
    desktop.command = "${pkgs.niri}/bin/niri-session";
  };
}
