{
  lib,
  pkgs,
  ...
}:

let
  apps = import ./packages/apps.nix { inherit pkgs; };
  dev = import ./packages/dev.nix { inherit pkgs; };
  cli = import ./packages/cli.nix { inherit pkgs; };
  fonts = import ./packages/fonts.nix { inherit pkgs; };
in
{

  home.packages = apps ++ dev ++ cli ++ fonts;

  # Automatic font cache update
  home.activation.updateFontCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.fontconfig}/bin/fc-cache -f || echo "fc-cache failed"
  '';

  programs = {
    anki.enable = true;
    fish.enable = true;
    fzf.enable = true;
    neovim.enable = true;
    obsidian = {
      enable = true;
      vaults.Notes = {
        enable = true;
        target = "Notes";
      };

    };
    zathura.enable = true;
    zen-browser = {
      enable = true;
      # profiles = {
      #   "Default Profile" = { };
      # };
    };
  };
}

# # It is sometimes useful to fine-tune packages, for example, by applying
# # overrides. You can do that directly here, just don't forget the
# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
# # fonts?
# (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

# # You can also create simple shell scripts directly inside your
# # configuration. For example, this adds a command 'my-hello' to your
# # environment:
# (pkgs.writeShellScriptBin "my-hello" ''
#   echo "Hello, ${config.home.username}!"
# '')
