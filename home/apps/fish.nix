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

    home.packages = with pkgs; [
      nix-your-shell
      eza
      rip2
    ];

    home.sessionVariables = {
      CFLAGS = "-std=c99 -Wall -Werror";
      GOPATH = "$HOME/.go";
      GOPROXY = "https://proxy.golang.org";
      GOSUMDB = "sum.golang.org";
      RIP_GRAVEYARD = config.home.homeDirectory + "/.local/share/Trash";
    };

    # home.shell.enableShellIntegration is default
    programs.nix-your-shell.enable = true;
    programs.zoxide.enable = true;
    programs.tirith.enable = true;

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

        if set -q TMUX
            if test (count (tmux list-windows)) -gt 3
                set_color -o red
                echo "BTW you should only have 3 tabs cause lowkey the 1 is for vim, 2 is for cmdline and 3rd is wild card. no more brochacho"
                set_color normal
            end
        else if type -q tmux
            t 
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

    xdg.configFile."fish/conf.d/hydro.fish".source = ../../dump/.config/fish/conf.d/hydro.fish;
    # "fish/completions".source = ../../dump/.config/fish/completions;
    # "fish/config.fish".source = lib.mkForce ../../dump/.config/fish/config.fish;
    # "fish/functions".source = ../../dump/.config/fish/functions;

    # Start up script using a dash ENV instead of bash
    home.file.".shinit".text = ''
      if [ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" ]; then
        SHELL=${pkgs.fish}/bin/fish ${pkgs.fish}/bin/fish
        status=$?

        if [ "$status" -eq 0 ]; then
            exit 0
        else
            echo "Program exited abnormally (status $status)."
        fi
      fi
    '';

  };

}
