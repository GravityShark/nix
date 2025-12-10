{ pkgs, ... }:

let
  wc = "scroll";
in
{
  programs.scroll.enable = true;

  environment.systemPackages = with pkgs; [
    brightnessctl
    sway
    greetd
    labwc
    grim
    slurp
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
