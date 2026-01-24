{ lib, ... }:

{
  imports = [
    ./apps
    ./desktop
    ./home
    ./services
  ];

  programs.home-manager.enable = true;

  nixpkgs.config = {
    allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "graalvm-oracle"
        "lunarclient"
        # "obsidian"
        "p7zip"
      ];

    # https://www.joseferben.com/posts/installing_only_certain_packages_from_an_unstable_nixos_channel
  };

  nixpkgs.overlays = [
    (final: prev: {
      waywall = prev.waywall.overrideAttrs (
        f: p: {
          version = "0.2026.01.11";
          src = prev.fetchFromGitHub {
            owner = "tesselslate";
            repo = "waywall";
            tag = f.version;
            hash = "sha256-VOtwVFMGgUvsGnD1CnflKtUy5tTKqK2C/qNsWwgbyEU=";
          };
        }
      );
    })

  ];
  # Paths doesnt work!!
  # home.sessionPath = [
  #   "$HOME/.local/bin"
  #   "$HOME/.scripts"
  #   "$HOME/.emacs.d/bin"
  # ];

  # xdg.desktopEntries.discord = {
  #   name = "Messenger";
  #   exec = "chromium --app=https://messenger.com";
  # };

  # home.sessionVariables = {
  #   GOPATH = "$HOME/.go";
  #   GOPROXY = "https://proxy.golang.org";
  #   GOSUMDB = "sum.golang.org";
  # };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'.
  # home.sessionVariables = {
  #   EDITOR = "nvim";
  # };
  # These will be explicitly sourced when using a shell provided by
  # Home Manager. If you don't want to manage your shell through Home Manager
  # then you have to manually source 'hm-session-vars.sh' located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # or
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  # or
  #  /etc/profiles/per-user/gravity/etc/profile.d/hm-session-vars.sh

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
}
