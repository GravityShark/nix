function fish_prompt --description Hydro
    echo -e "$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $$_hydro_git$_hydro_color_duration$_hydro_cmd_duration"
    set -l nix_shell_info (
      if test -n "$IN_NIX_SHELL"
        echo -n "<nix-shell> "
        echo
      end
    )
    echo -e "$hydro_color_normal$_hydro_status$hydro_color_normal"
end
