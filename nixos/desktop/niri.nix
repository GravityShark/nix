{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  config = lib.mkIf (config.desktop.display-server == "niri") {
    # Niri screen tearing
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;

    programs.niri.enable = true;
    environment.systemPackages = with pkgs; [
      git # NOTE: I have no clue why sodiboo/niri needs git like this
      xwayland-satellite
    ];
    desktop.command = "${pkgs.niri}/bin/niri-session";
  };
}
