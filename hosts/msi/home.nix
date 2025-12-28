{ ... }:

{
  desktop-entries.enable = false;
  links.enable = true;
  mime.enable = false;

  apps = {
    desktop.enable = true;
    dev.enable = true;
    ghostty.enable = true;
    neovim.enable = true;
    nixcraft.enable = true;
    syncthing.enable = true;
    yo.enable = true;
    zen-browser.enable = true;
    tmux.enable = true;
  };

  desktop = {
    niri.enable = true;
    noctalia.enable = true;
    stylix = {
      enable = true;
      theme = "gruvbox-material-light";
    };
  };

  service = {
    notes-backup.enable = true;
    keepassxc.enable = true;
    swayidle.enable = true;
  };

  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.
}
