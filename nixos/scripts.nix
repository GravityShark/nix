{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    scripts.enable = lib.mkEnableOption "enables scripts";
  };
  config = lib.mkIf config.scripts.enable {
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "fe" ''
        $EDITOR ~/.nix/flake.nix && nixfmt ~/.nix/*.nix
      '')

      (writeShellScriptBin "fu" ''
        nix flake update --flake ~/.nix
      '')

      (writeShellScriptBin "hmn" ''
        home-manager news --flake ~/.nix
      '')

      (writeShellScriptBin "hms" ''
        home-manager switch --flake ~/.nix
      '')

      (writeShellScriptBin "ng" ''
        cd ~/.nix &&
                git add . &&
                (git diff --cached --quiet ||
                        (git commit -m "Update configuration" -S >/dev/null 2>&1 &&
                                git push >/dev/null 2>&1)) &
      '')

      (writeShellScriptBin "ngc" ''
        sudo nix-collect-garbage -d
        sudo nix-store --optimise
        sudo nix-store --gc
        home-manager expire-generations 1
        nix-collect-garbage -d
      '')

      (writeShellScriptBin "nrb" ''
        sudo nixos-rebuild boot --flake ~/.nix
      '')

      (writeShellScriptBin "nrbu" ''
        sudo nixos-rebuild boot --upgrade --flake ~/.nix
      '')
      (writeShellScriptBin "nrs" ''
        sudo nixos-rebuild switch --flake ~/.nix
      '')
      (writeShellScriptBin "updatescript" ''
        ng && fu && nrsu && hms
      '')
    ];
  };
}
