{ pkgs, ... }:

{
  programs.mangowc.enable = true;

  environment.systemPackages = with pkgs; [
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
  ];
}
