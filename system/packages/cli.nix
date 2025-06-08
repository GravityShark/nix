{
  pkgs ? import <nixpkgs> { },
}:

with pkgs;
[
  # CLIs
  # bc
  dash
  fish
  doas-sudo-shim
  efibootmgr
  eza
  fastfetch
  fd
  ffmpeg
  fzf
  git
  hunspell
  hunspellDicts.en_US
  joshuto
  neovim
  restic
  ripgrep
  tmux
  unzip
  wl-clipboard
  yt-dlp
  ytfzf
  zoxide
]
