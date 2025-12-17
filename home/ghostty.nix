{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    enableFishIntegration = true;
    package = pkgs.ghostty;
    settings = {
      # command = "${pkgs.fish}/bin/fish --login --interactive";
      confirm-close-surface = false;
      cursor-style = "block";
      font-family = "Aporetic Sans Mono";
      font-size = 11;
      gtk-single-instance = true;
      gtk-titlebar = false;
      quit-after-last-window-closed = false;
      shell-integration-features = "no-cursor";
      shell-integration = "fish";
      theme = "Gruvbox Material Light";
      window-decoration = "none";
    };
    systemd.enable = false;
  };
}
