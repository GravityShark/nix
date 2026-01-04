{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    apps.fish.enable = lib.mkEnableOption "enables fish";
  };
  config = lib.mkIf config.apps.fish.enable {
    assertions = [
      {
        assertion = config.apps.fzf.enable;
        message = "apps.fish would not function properly without apps.fzf";
      }
    ];

    programs.fish = {
      enable = true;
      functions = {
        fish_greeting = "";
        fish_prompt = ''
          set -l nix_shell_info (
                if test -n "$IN_NIX_SHELL"
                  set_color blue
                  echo -n "<nix-shell> "
                  set_color normal
                end
              )
              echo -e "$_hydro_color_pwd$_hydro_pwd$hydro_color_normal $$_hydro_git$_hydro_color_duration$_hydro_cmd_duration$nix_shell_info$hydro_color_normal$_hydro_status$hydro_color_normal"
        '';
      };
      shellAliases = {
        l = "eza --icons --long --all --sort=time --time=accessed $argv";
        ls = "eza --icons --group-directories-first --sort=name $argv";
        rm = "rip";
      };
      shellAbbrs = {
        x = "xdg-open";
      };
      interactiveShellInit = ''
        set fish_greeting # Disable greeting

        fish_add_path $HOME/.scripts
        fish_add_path $HOME/.scripts/aliases
        set --export EDITOR nvim
        set --export SYSTEMD_EDITOR nvim
        set --export VISUAL nvim
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
        set CFLAGS '-std=c99 -Wall -Werror'

        if set -q TMUX
            if test (count (tmux list-windows)) -gt 3
                echo "BTW you should only have 3 tabs cause lowkey the 1 is for vim, 2 is for cmdline and 3rd is wild card. no more brochacho"
            end
        else if type -q tmux
            tmux
        end

      '';
      plugins = [
        # Enable a plugin (here grc for colorized command output) from nixpkgs
        {
          name = "bass";
          src = pkgs.fishPlugins.bass.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "puffer";
          src = pkgs.fishPlugins.puffer.src;
        }
        {
          name = "sponge";
          src = pkgs.fishPlugins.sponge.src;
        }
      ];
    };

    home.packages = with pkgs; [
      nix-your-shell
      eza
      rip2
    ];

    programs.nix-your-shell = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    xdg.configFile."fish/conf.d/hydro.fish".source = ../../dump/.config/fish/conf.d/hydro.fish;
    # "fish/completions".source = ../../dump/.config/fish/completions;
    # "fish/config.fish".source = lib.mkForce ../../dump/.config/fish/config.fish;
    # "fish/functions".source = ../../dump/.config/fish/functions;

    home.file."mkshrc".text = ''
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      case "$-" in 
          *i*)
              if SH=$(which fish); then
                  SELL=$SH fish
                  status=$?
                  
                  if [ "$status" -eq 0 ]; then
                      exit 0
                  else
                      echo "Program exited abnormally (status $status)."
                  fi
              fi
          ;;
      esac
    '';
  };

}
