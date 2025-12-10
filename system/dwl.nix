{ pkgs, ... }:

let
  wc = "scroll";
in
{
  programs.scroll.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    dwl
    greetd
    grim
    htop
    labwc
    slurp
    sway
    swaybg
    wiremix
    wl-clipboard
    wmenu
  ];

  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      initial_session = {
        command = "${wc}";
        user = "gravity";
      };

      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd ${wc}";
        user = "greeter";
      };
    };
  };
}
