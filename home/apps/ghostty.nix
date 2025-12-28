{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.ghostty.enable = lib.mkEnableOption "enables ghostty";
  };

  config = lib.mkIf config.apps.ghostty.enable {
    programs.ghostty = {
      enable = true;
      # clearDefaultKeybinds = true;
      enableFishIntegration = true;
      settings = {
        # command = "${pkgs.fish}/bin/fish --login --interactive";
        confirm-close-surface = false;
        cursor-style = "block";
        font-family = lib.mkDefault "Aporetic Sans Mono";
        font-size = lib.mkDefault 13;
        gtk-single-instance = true;
        gtk-titlebar = false;
        quit-after-last-window-closed = false;
        shell-integration-features = "no-cursor";
        shell-integration = "fish";
        theme = lib.mkDefault "Gruvbox Material Light";
        window-decoration = "none";
      };
      systemd.enable = false;
    };

    home.activation.reloadGhostty = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${pkgs.procps}/bin/pkill -SIGUSR2 ghostty
    '';
  };
}
