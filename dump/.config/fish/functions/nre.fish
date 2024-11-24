function nre --wraps='nvim ~/.nix && nixfmt ~/.nix/*' --description 'alias nre nvim ~/.nix && nixfmt ~/.nix/*'
  $EDITOR ~/.nix/configuration.nix && nixfmt ~/.nix/* $argv
        
end
