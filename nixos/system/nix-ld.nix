{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    system.nix-ld.enable = lib.mkEnableOption "enables nix-ld";
  };
  config = lib.mkIf config.system.nix-ld.enable {
    # https://wiki.nixos.org/wiki/Nix-ld
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        libvlc
        sdl3
        SDL
        SDL2
        SDL_gfx
        mesa
      ];
    };
  };
}
