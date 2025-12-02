{
  pkgs,
  ...
}:

# List packages installed in system profile. To search, run:
# $ nix search wget

let
  apps = import ./packages/apps.nix { inherit pkgs; };
  dev = import ./packages/dev.nix { inherit pkgs; };
  cli = import ./packages/cli.nix { inherit pkgs; };
in
{
  environment.systemPackages = apps ++ dev ++ cli ++ [ pkgs.home-manager ];
}
