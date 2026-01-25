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
        font-family = lib.mkdefault "aporetic sans mono";
        font-family-italic = lib.mkdefault "victor mono";
        font-size = lib.mkDefault 13;
        gtk-single-instance = true;
        gtk-titlebar = false;
        quit-after-last-window-closed = false;
        shell-integration-features = "no-cursor";
        shell-integration = "fish";
        theme = lib.mkDefault "Gruvbox Material Light";
        window-decoration = "none";
        keybind = "ctrl+enter=unbind";
      };
      systemd.enable = false;
    };

    home.activation.reloadGhostty =
      let
        after = if (config.desktop.stylix.enable) then "stylixLookAndFeel" else "writeBoundary";
      in
      (lib.hm.dag.entryAfter [ after ] ''
        ${pkgs.procps}/bin/pkill -SIGUSR2 ghostty
      '');

    home.packages = with pkgs; [ xdg-terminal-exec ];
    xdg.configFile = {
      "xdg-terminals.list".source = ../../dump/.config/xdg-terminals.list;
    };
  };
}
