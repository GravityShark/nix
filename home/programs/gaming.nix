{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bubblewrap
    dwarfs
    fuse-overlayfs
    wineWowPackages.staging
  ];
}
