# https://git.uku3lig.net/uku/mcsr-nixos/src/branch/main/pkgs/graalvm-21.nix#
{
  lib,
  stdenv,
  fetchurl,
  graalvmPackages,
  useMusl ? false,
}:

let
  hashes = {
    "x86_64-linux" = {
      url = "https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-x64_bin.tar.gz";
      hash = "";
    };
    "aarch64-linux" = {
      url = "https://download.oracle.com/graalvm/21/latest/graalvm-jdk-21_linux-aarch64_bin.tar.gz";
      hash = "";
    };
  };
in
graalvmPackages.buildGraalvm {
  pname = "graalvm-oracle";
  version = "21-latest";

  src = fetchurl hashes.${stdenv.hostPlatform.system};

  inherit useMusl;

  meta.platforms = lib.platforms.linux;
}
