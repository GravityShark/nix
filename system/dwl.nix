{ dwl-grav, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    dwl-grav.default
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
        command = "dwl";
        user = "gravity";
      };

      default_session = {
        command = "agreety --cmd dwl";
        user = "greeter";
      };
    };
  };
}
