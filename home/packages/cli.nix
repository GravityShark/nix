{ pkgs }:

with pkgs;
[
  # CLIs
  nix-your-shell
  sesh
  tomato-c
  xdg-terminal-exec

  pkgs.texlive.combine
  {
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
]
