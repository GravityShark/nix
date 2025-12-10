{ ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      confirm-close-surface = false;
      cursor-style = "block";
      font-family = "Aporetic Sans Mono";
      font-size = 11;
      gtk-single-instance = true;
      gtk-titlebar = false;
      shell-integration-features = "no-cursor";
      theme = "Gruvbox Material Light";
      window-decoration = "none";
    };
  };

  systemd.user.services."app-com.mitchellh.ghostty".enable = true;
  home.file.".config/ghostty".source = dump/.config/ghostty;
}
