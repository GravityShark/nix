{ pkgs, ... }:

{
  home.packages = with pkgs; [
    obs-studio
    prismlauncher
    temurin-jre-bin
    waywall
    lunar-client
  ];
}
