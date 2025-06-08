{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
[
  clang
  gnumake
  go
  nodejs
  python3
  racket
]
