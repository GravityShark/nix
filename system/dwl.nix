{
  dwl-grav,
  pkgs,
  ...
}:

let
  wc = "sway";
in
{
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
    grim
    slurp
    swaybg
    wiremix
    wl-clipboard
    wmenu
  ];

  services.greetd = {
    enable = false;
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
