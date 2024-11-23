function nre --wraps='nvim ~/.nix && nixfmt ~/.nix/*' --description 'alias nre nvim ~/.nix && nixfmt ~/.nix/*'
  nvim ~/.nix && nixfmt ~/.nix/* $argv
        
end
