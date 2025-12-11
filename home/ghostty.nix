{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    clearDefaultKeybinds = true;
    enableFishIntegration = true;
    package = pkgs.ghostty;
    settings = {
      confirm-close-surface = false;
      cursor-style = "block";
      font-family = "Aporetic Sans Mono";
      font-size = 11;
      gtk-single-instance = true;
      gtk-titlebar = false;
      quit-after-last-window-closed = false;
      shell-integration-features = "no-cursor";
      theme = "Gruvbox Material Light";
      window-decoration = "none";
    };
  };
}
