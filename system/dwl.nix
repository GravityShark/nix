{
  dwl-grav,
  pkgs,
  ...
}:

let
  wc = "dwl";
in
{
  programs.scroll.enable = true;
  programs.mango.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    dwl-grav.default
    sway
    greetd
    niri
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
