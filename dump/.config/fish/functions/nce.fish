function nce --wraps='nvim ~/.nix && nixfmt ~/.nix/*' --description 'alias nce nvim ~/.nix && nixfmt ~/.nix/*'
  nvim ~/.nix && nixfmt ~/.nix/* $argv
        
end
