{ ... }:

{
  desktop-entries.enable = false;
  links.enable = true;
  mime.enable = false;

  apps = {
    ghostty.enable = true;
    neovim.enable = true;
    nixcraft.enable = true;
    syncthing.enable = true;
    yo.enable = true;
    zen-browser.enable = true;
  };

  desktop = {
    stylix.enable = true;
    noctalia.enable = true;
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

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gravity";
  home.homeDirectory = "/home/gravity";

}
