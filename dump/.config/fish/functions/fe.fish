function fe --wraps='nvim ~/.nix/flake.nix && nixfmt ~/.nix/*' --description 'alias fe nvim ~/.nix/flake.nix && nixfmt ~/.nix/*'
  nvim ~/.nix/flake.nix && nixfmt ~/.nix/* $argv
        
end
