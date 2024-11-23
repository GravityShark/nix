function nrs --wraps='nix flake update ~/.nix && doas chmod 777 /dev/null && doas nixos-rebuild switch --flake ~/.nix' --description 'alias nrs nix flake update ~/.nix && doas chmod 777 /dev/null && doas nixos-rebuild switch --flake ~/.nix'
  nix flake update ~/.nix && doas chmod 777 /dev/null && doas nixos-rebuild switch --flake ~/.nix
        
end
