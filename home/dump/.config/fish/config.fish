if status is-interactive
    # variables tbh
    set --export EDITOR nvim
    set --export FZF_DEFAULT_COMMAND \x1d
    set --export FZF_DEFAULT_OPTS \x0a\x2d\x2dcolor\x3dfg\x3a\x23797593\x2cbg\x3a\x23faf4ed\x2chl\x3a\x23d7827e\x0a\x2d\x2dcolor\x3dfg\x2b\x3a\x23575279\x2cbg\x2b\x3a\x23f2e9e1\x2chl\x2b\x3a\x23d7827e\x0a\x2d\x2dcolor\x3dborder\x3a\x23dfdad9\x2cheader\x3a\x23286983\x2cgutter\x3a\x23faf4ed\x0a\x2d\x2dcolor\x3dspinner\x3a\x23ea9d34\x2cinfo\x3a\x2356949f\x2cseparator\x3a\x23dfdad9\x0a\x2d\x2dcolor\x3dpointer\x3a\x23907aa9\x2cmarker\x3a\x23b4637a\x2cprompt\x3a\x23797593\x0a\x2d\x2dborder\x3drounded\x0a
    set FZF_TMUX_HEIGHT 80\x25
    set --path GOPATH /home/gravity/Other/go
    set --export PAGER less \x2d\x2dRAW\x2dCONTROL\x2dCHARS
    set --export SYNCTHING_GROUP wheel
    set --export SYNCTHING_USER gravity
    set ZO_CMD zo
    set Z_CMD z
    set Z_DATA /home/gravity/\x2elocal/share/z/data
    set Z_DATA_DIR /home/gravity/\x2elocal/share/z
    set Z_EXCLUDE \x5e/home/gravity\x24
    set __fish_git_prompt_color_branch brmagenta
    set __fish_git_prompt_color_cleanstate brgreen
    set __fish_git_prompt_color_dirtystate blue
    set __fish_git_prompt_color_invalidstate red
    set __fish_git_prompt_color_stagedstate yellow
    set __fish_git_prompt_color_untrackedfiles cdd6f4
    set __fish_git_prompt_hide_untrackedfiles 1
    set __fish_git_prompt_show_informative_status 1
    set __fish_git_prompt_showupstream informative
    set __fish_initialized 3400
    set fish_color_autosuggestion 7596E4
    set fish_color_cancel \x2d\x2dreverse
    set fish_color_command 164CC9
    set fish_color_comment 007B7B
    set fish_color_cwd green
    set fish_color_cwd_root red
    set fish_color_end 02BDBD
    set fish_color_error 9177E5
    set fish_color_escape 00a6b2
    set fish_color_gray 6c7086
    set fish_color_history_current \x2d\x2dbold
    set fish_color_host normal
    set fish_color_host_remote \x1d
    set fish_color_keyword \x1d
    set fish_color_match \x2d\x2dbackground\x3dbrblue
    set fish_color_normal normal
    set fish_color_operator 00a6b2
    set fish_color_option \x1d
    set fish_color_param 4319CC
    set fish_color_quote 4C3499
    set fish_color_redirection 248E8E
    set fish_color_search_match bryellow \x2d\x2dbackground\x3dbrblack
    set fish_color_selection white \x2d\x2dbold \x2d\x2dbackground\x3dbrblack
    set fish_color_status f38ba8
    set fish_color_user brgreen
    set fish_color_valid_path \x2d\x2dunderline
    set fish_key_bindings fish_default_key_bindings
    set fish_pager_color_background \x1d
    set fish_pager_color_completion normal
    set fish_pager_color_description B3A06D
    set fish_pager_color_prefix normal \x2d\x2dbold \x2d\x2dunderline
    set fish_pager_color_progress brwhite \x2d\x2dbackground\x3dcyan
    set fish_pager_color_secondary_background \x1d
    set fish_pager_color_secondary_completion \x1d
    set fish_pager_color_secondary_description \x1d
    set fish_pager_color_secondary_prefix \x1d
    set fish_pager_color_selected_background \x2d\x2dbackground\x3dbrblack
    set fish_pager_color_selected_completion \x1d
    set fish_pager_color_selected_description \x1d
    set fish_pager_color_selected_prefix \x1d
    set --export plugins https\x3a//github\x2ecom/kidonng/plug\x2efish https\x3a//github\x2ecom/franciscolourenco/done https\x3a//github\x2ecom/nickeb96/puffer\x2dfish https\x3a//github\x2ecom/GravityShark0/safe-rm
    set CFLAGS '-std=c99 -Wall -Werror'

    alias s sesh
    alias x xdg-open
    if not source $__fish_user_data_dir/plugins/plug.fish/conf.d/plugin_load.fish
        echo -e "plug.fish doesn't seem to exist, trying to install"
        curl -L https://github.com/kidonng/plug.fish/raw/v3/conf.d/plugin_load.fish | source
        #set_color green; echo -e "To install plug.fish do  \ncurl -L https://github.com/kidonng/plug.fish/raw/v3/conf.d/plugin_load.fish | source"
        #set_color normal
    end
    fzf_key_bindings        
    zoxide init fish | source

    if command -q nix-your-shell
      nix-your-shell fish | source
    end

    # if command -v tmux > /dev/null and test -n "$PS1" and not echo $TERM | grep -q 'tmux' and test -z "$TMUX"
    # if command -v tmux > /dev/null 'tmux'; and not set -q "$TMUX"
    if type -q tmux ; and not set -q TMUX
        tmux
    end

end
