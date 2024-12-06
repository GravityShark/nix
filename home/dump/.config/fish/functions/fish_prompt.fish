function fish_prompt --description Hydro
    set -l nix_shell_info (
      if test -n "$IN_NIX_SHELL"
        set_color blue
        echo -n "<nix-shell>"
        set_color normal
      end
    )
    echo -e "$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $$_hydro_git$_hydro_color_duration$_hydro_cmd_duration$nix_shell_info$hydro_color_normal$_hydro_status$hydro_color_normal"
end
