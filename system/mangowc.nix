{ pkgs, ... }:

{
  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
  ];
}
