{ pkgs, ... }:

{
  services.displayManager.autoLogin = {
    enable = true;
    user = "gravity";
  };

  programs.mango.enable = true;

  environment.systemPackages = with pkgs; [
    wmenu
    wl-clipboard
    grim
    slurp
    swaybg
    brightnessctl
  ];
}
