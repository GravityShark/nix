# nvim-kick

> use neovim 0.10

> cause fuck yeah only latest baby

## whats different about this one

i used to have one big plugins.lua with all my plugins.
this was a bit of a hassle because whenever i update it,
lazy will fail to load the other plugins (including the theme),
so i had to close neovim again and reopen it.

sometimes i want to enable or disable a plugin.
of course i can just use `enabled = false`, but lazy still needs
to parse it which is slow in my eyes.
so i just comment it in my big plugins.lua which is kinda hard
to navigate if you dont have folds, and even then its still
chunky.

i wanted to try what everyone else was doing so
now its all fragmented into their own .lua file, so i can
just put it in the folder (`lua/pluggers`) that lazy.nvim uses
and it is enabled.

then i got a problem to solve. theres too much friction moving
plugins using mv ?.lua disabled/?.lua when i wanted to disable
one. and i wanted to categorize them so its easy which plugin
i wanna change or add to.

i first tried using a POSIX shell and it was horrible.
probably because im bad at making scripts but i more blamed it
on shell being a shitty language to write in

so i created `relink.go` which basically automates symlinking
by the `enabled-plugins.txt` file and it works wonderfully tbh.
and much easier to write than in shell. probably the first time
i ever used go as a sort of cli tool or script

### plugins i have to look into

- [Neotest](https://github.com/nvim-neotest/neotest) (very interesting)
- [submode.nvim](https://github.com/pogyomo/submode.nvim) (very very interesting)
- [octo.nvim](https://github.com/pwntester/octo.nvim) if i become successful one day
  - [cmp-git](https://github.com/petertriho/cmp-git)
- new neovim look
  - [nvim-notify](https://github.com/rcarriga/nvim-notify)
  - [dressing.nvim](https://github.com/stevearc/dressing.nvim) dresses
  - [noice.nvim](https://github.com/folke/noice.nvim)
- [kulala.nvim](https://github.com/mistweaverco/kulala.nvim)
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
- Colorscheming
  - [mini.base16](https://github.com/echasnovski/mini.base16) -- coolors
  - [mini.colors](https://github.com/echasnovski/mini.colors) or[lush](https://github.com/rktjmp/lush.nvim)
  - [mini.hues](https://github.com/echasnovski/mini.hues)

### plugins i looked into

- [Neogen](https://github.com/danymat/neogen) (kinda interesting)
  - automatically puts an annotation which is very nice and works better than snippets can
- Bufferline plugins (mini.tabline, bufferline.nvim, etc...)

  - I've been thinking about how you should go about in a
    project and I am currently trying to ditch bufferlines
    or buffer related workflow and try ThePrimeagen's Harpoon
    where he sets 4 main files that he constantly goes to and
    only goes to the other files via file picker or lsp get def.
  - My buffer workflow

    - It's basically just vim tabs but better
    - How
      - open a workspace with [persistence.nvim](https://github.com/folke/persistence.nvim)
      - persistence will open all the buffers you used before
      - go through the buffers one by one
      - or jump to a specific buffer with a single chord
      - close a buffer if you no longer need it
      - use any file picker to open the file you want in a buffer
        - Telescope or netrw
    - Keybindings
      - Tab, <S-Tab> = :bnext, :bprev
      - <A-[1-9]> = jump to bufferline index 1-9
      - <Leader>c = close buffer

### Shitty idea

> what if i make a neovim distro purely made to be mouse and input mode only

> sounds stupid but there is a lack of extremely lightweight (i. e. cli/tui) text editors out there that have good functionality

> and its made for people who wont even learn vim motions but be able to use its amazing ecosystem - im gonna name it devil.nvim (de-evil like evil mode in emacs) or like good.nvim (opposite of evil) - or like neo as in taking the vim out of neovim

> kinda like a modern [evim](https://linux.die.net/man/1/evim)

## install

> you might wanna do the uninstall instruction first so no conflicts arise

```bash
git clone https://github.com/GravityShark0/nvim-kick.git ~/.config/nvim
# then run the relink command with your preferred plugins
cd ~/.config/nvim
./relink.out
```

> then you go ahead change the lua/ensure.lua to set what kind of
> lsp, treesitter, formatters, and linters you wanna have

then run `nvim` or wheatever neovim client you use

> like [neovide](https://neovide.dev/)

## uninstall

```bash
# will completely remove anything in neovim
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
```

- thanks [kickstart.nvim]
