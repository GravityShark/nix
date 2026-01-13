{
  lib,
  config,
  pkgs,
  ...
}:

{
  options = {
    update-scripts.enable = lib.mkEnableOption "enables scripts that are useful for maintaining nixos";
  };

  config = lib.mkIf config.update-scripts.enable {
    environment.systemPackages = with pkgs.writers; [
      (writeDashBin "fe" ''
        $EDITOR ~/.nix/flake.nix && nixfmt ~/.nix/*.nix
      '')

      (writeDashBin "fu" ''
        nix flake update --flake ~/.nix "$@"
      '')

      (writeDashBin "hmn" ''
        home-manager news --flake ~/.nix
      '')

      (writeDashBin "hms" ''
        home-manager switch --flake ~/.nix\?submodules=1 "$@"
      '')

      (writeDashBin "ng" ''
        cd ~/.nix &&
                git add . &&
                (git diff --cached --quiet ||
                        (git commit -m "Update configuration" -S >/dev/null 2>&1 &&
                                git push >/dev/null 2>&1)) &
      '')

      (writeDashBin "ngc" ''
        sudo nix-collect-garbage -d
        sudo nix-store --optimise
        sudo nix-store --gc
        home-manager expire-generations 1
        nix-collect-garbage -d
      '')

      (writeDashBin "nrb" ''
        sudo nixos-rebuild boot --flake ~/.nix "$@"
      '')

      (writeDashBin "nrbu" ''
        sudo nixos-rebuild boot --upgrade --flake ~/.nix "$@"
      '')
      (writeDashBin "nrs" ''
        sudo nixos-rebuild switch --flake ~/.nix "$@"
      '')
      (writeDashBin "nrsu" ''
        sudo nixos-rebuild switch --upgrade --flake ~/.nix "$@"
      '')
      (writeDashBin "updatescript" ''
        ng && fu && nrsu && hms
      '')
    ];
  };
}
