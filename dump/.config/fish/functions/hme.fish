function hme --wraps='nvim ~/.nix/home.nix && nixfmt ~/.nix/*' --description 'alias hme nvim ~/.nix/home.nix && nixfmt ~/.nix/*'
  nvim ~/.nix/home.nix && nixfmt ~/.nix/* $argv
        
end
