{ config, ... }:

{
  imports = [
    ./gnome.nix
    ./labwc.nix
    # ./mango.nix
    ./niri.nix
    ./noctalia.nix
    ./stylix.nix
  ];

  # NOTE: idk where else to put this
  gtk.gtk3.bookmarks = [
    "file:///home/${config.home.username}/Code Code"
    "file:///home/${config.home.username}/Desktop Desktop"
    "file:///home/${config.home.username}/Documents Documents"
    "file:///home/${config.home.username}/Downloads Downloads"
    "file:///home/${config.home.username}/Games Games"
    "file:///home/${config.home.username}/.local/share Local Share"
    "file:///home/${config.home.username}/Music Music"
    "file:///home/${config.home.username}/Notes Notes"
    "file:///home/${config.home.username}/Pictures"
    "file:///home/${config.home.username}/Pictures/Screenshots Screenshots"
    "file:///home/${config.home.username}/Videos Videos"
  ];
}
