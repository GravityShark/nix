{
  config,
  pkgs,
  zen-browser,
  ...
}:
let
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        dvisvgm
        dvipng # for preview and export as html
        wrapfig
        amsmath
        ulem
        hyperref
        capt-of
        etoolbox
        nopageno
        mlmodern
        metafont
        ;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
    }
  );
in
{
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    authenticator
    foliate
    fragments # Bittorrent client
    gnome-epub-thumbnailer
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.pop-shell
    gnomeExtensions.run-or-raise
    gnome-frog
    iosevka-comfy.comfy
    iosevka-comfy.comfy-wide-motion
    nerd-fonts.fira-code
    nerd-fonts.iosevka
    nixfmt-rfc-style
    sesh
    ungoogled-chromium
    vial
    webcord
    tex
    zen-browser.specific
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
  ];
}
