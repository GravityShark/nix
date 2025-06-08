{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
[
  aporetic
  nerd-fonts.iosevka
  source-sans-pro
  # nerd-fonts.ubuntu-sans
]
