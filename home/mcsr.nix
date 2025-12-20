{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # graalvmPackages.graalvm-ce
    javaPackages.compiler.temurin-bin.jre-21
    prismlauncher
    waywall
    chromium
  ];
}
