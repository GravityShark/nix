# nvim-kick

> use the latest and greatest neovim (0.11 rn)

> cause fuck yeah only latest baby

> also this assumes you install all of your dependencies using nix lol, so no Mason for you

> i mean mason is kinda still available as a plugin so you can still use it and just put your mason stuff in ensure.lua then the M.mason

## whats different about this one

> tl;dr read ./enabled-plugins.txt

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
plugins using `mv PLUGIN.lua disabled/PLUGIN.lua` when i wanted to disable
one. and i wanted to categorize them so its easy which plugin
i wanna change or add to.

i first tried using shell scriptinng and it was horrible.
probably because im bad at making scripts but i more blamed it
on shell being a shitty language to write in

so i created [relink.go] which basically automates symlinking
by the [enabled-plugins.txt] file and it works wonderfully tbh.
and much easier to write than in shell. probably the first time
i ever used go as a sort of cli tool or script or even just making my own
cli for a specific purpose

## plugins i have to look into

- [mini.move](https://github.com/nvim-mini/mini.move) adds the primeagen mapping to move a selaction up and down
- [outline.nvim](https://github.com/hedyhli/outline.nvim) a sort of table of contents for your code
- [overseer.nvim](https://github.com/stevearc/overseer.nvim) job and task management, like github actions or bulids
- [mini.snippets](https://github.com/nvim-mini/mini.snippets) custom snippets that are easy to write like coq
  - https://cmp.saghen.dev/configuration/snippets.html#mini-snippets

- make dap work well
- or just make testing just a lil easier

- this guy's config https://www.youtube.com/watch?v=NkQnPuidxWY
  1. sessions (persistence)
     - actually dont like this
     - im gonna use arrow.nvim instead
  2. tree like thing (i use netrw because yeah)
     - i like the float, might never use, im gonna get like oil.nvim instead though
     - i installed oil and its good
  3. breadcrumbs.nvim / nvim-navic
     - idk maybe
  4. automatic test opening stuff
     - cool

- [literally](https://github.com/dinhhuy258/sfm.nvim) [any](https://github.com/nvim-tree/nvim-tree.lua) [tree](https://github.com/ms-jpq/chadtree) [plugin](https://github.com/nvim-neo-tree/neo-tree.nvim) or [file](https://github.com/SidOfc/carbon.nvim) [explorer](https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file#file-explorer)
  - [oil.nvim](https://github.com/stevearc/oil.nvim)
    - oil is really cool, but there is another
  - [fyler.nvim](https://github.com/A7Lavinraj/fyler.nvim)
    - one thing i kinda want to have is
    - currently really buggy and is missing some features i still have to add

- [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) so that i dont use
  this, i should really setup a keybind/or atleast a note on how to do good
  native search and replace
  1. populate the arglist using telescope `<Leader>fl` or `Telescope live_grep`
  2. `:cdo %s/{old}/{new}/g`
- [treewalker.nvim](https://github.com/aaronik/treewalker.nvim) for somereason this plugin only existed now?
- [flash.nvim](https://github.com/folke/flash.nvim) i have not used flash (or any similar) before and im hesitant to change to one
- [vim-dadbod-completion](https://github.com/kristijanhusak/vim-dadbod-completion) database completion from within neovim
- [distant.nvim](https://github.com/chipsenkbeil/distant.nvim) remote work on neovim!!
- [nvim-dap](https://github.com/mfussenegger/nvim-dap) i can NOt make this shit work for some reason
- [Neotest](https://github.com/nvim-neotest/neotest) (very interesting)
- [submode.nvim](https://github.com/pogyomo/submode.nvim) (very very interesting)
  - iirc which-key.nvim also now has hydra stuff
- Git plugins, only for when Im gonna be managing alot of gits in the future, but right now i do a little hack ;)
  - [octo.nvim](https://github.com/pwntester/octo.nvim) if i become successful one day
    - [gh.nvim](https://github.com/ldelossa/gh.nvim) github integration that is more than just rhubar
      - [cmp-git](https://github.com/petertriho/cmp-git)
  - [neogit](https://github.com/NeogitOrg/neogit) or even just [magit](https://magit.vc/) on emacs, or just [lazygit](https://github.com/jesseduffield/lazygit)
- new neovim look
  - [nvim-notify](https://github.com/rcarriga/nvim-notify)
  - [dressing.nvim](https://github.com/stevearc/dressing.nvim) dresses
    - i already use this now using snacks.nvi/ui
  - [noice.nvim](https://github.com/folke/noice.nvim)
- [kulala.nvim](https://github.com/mistweaverco/kulala.nvim) - its like an HTTP testing server
- [refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)
- Colorscheming
  - [mini.base16](https://github.com/nvim-mini/mini.base16) -- coolors
  - [mini.colors](https://github.com/nvim-mini/mini.colors) or[lush](https://github.com/rktjmp/lush.nvim)
  - [mini.hues](https://github.com/nvim-mini/mini.hues)

## plugins i looked into

- [Neogen](https://github.com/danymat/neogen) (kinda interesting)
  - automatically puts an annotation which is very nice and works better than snippets can
  - mainly for like lua it does well
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
- [netrw.nvim](https://github.com/prichrd/netrw.nvim)
  - netrw is mid i just realized, never having ts ever again :pray:
  - oil.nvim or fyler.nvim is fetter

## Shitty idea

> what if i make a neovim distro purely made to be mouse and input mode only

> sounds stupid but there is a lack of extremely lightweight (i. e. cli/tui) text editors out there that have good functionality

> and its made for people who wont even learn vim motions but be able to use its amazing ecosystem - im gonna name it devil.nvim (de-evil like evil mode in emacs) or like good.nvim (opposite of evil) - or like neo as in taking the vim out of neovim

> kinda like a modern [evim](https://linux.die.net/man/1/evim)

## install

> you might wanna do the uninstall instruction first so no conflicts arise

```bash
git clone https://github.com/GravityShark/nvim-kick.git ~/.config/nvim
cd ~/.config/nvim
git config --local include.path ../.gitconfig
# then run the relink command with your preferred plugins
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

- thanks [kickstart.nvim]

## note
nvim servers exist, might use it to create cool shit like cool tranitions with mini.color a

```
