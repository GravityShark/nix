{ pkgs, ... }:

{
  home.packages = with pkgs; [
    graalvm-ce
    javaPackages.compiler.temurin-bin.jre-21
    prismlauncher
    waywall
  ];
}
