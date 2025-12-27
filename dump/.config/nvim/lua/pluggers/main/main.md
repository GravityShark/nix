# main.md

Plugins that provide functionality that is bigger than extras

## _completion menus_

completion menu for your dirty intellisense

- only one is allowed

### blink

the batteries included completion menu

### _cmp_

the i guess also good completion menu

### coq

the fast as FUCK completion menu

## _conform_

Formatting of code

- remember to setup **ensure.lua** for your formatters

## dap (not working)

Interface for debuging of code

## _lint_

Automatic linting of code

- remember to setup **ensure.lua** for your linters

## _lsp_

easier setup for stuff using language servers

- remember to setup **ensure.lua** for your language servers
- recommended to use with a _completion menu_

## _mason_

- Allows installing of LSPs, Linters, and Formatters automatically and locally in neovim
- Doesn't work well with NixOS `:(`

## neotest (incomplete)

- Interface for interacting with tests in neovim

## snacks

- a bunch of small little utilities that do great things to the world
- enabled :
  1. bigfile - does not things like lsps for files that are big
  2. bufdelete - good ol' bdel but good
  3. image - adds 3rd/image.nvim but actually works!?
  4. quickfile - tries to load the file as fast as possible before anything else
  5. rename - when you are in something like oil.nvim (it's enabled for that btw)
     and you rename a file that another file needs (like its referincing that)
     it renames it in the referencing code too

## _telescope_

a fuzzy finder written entirely in lua allowing you to find files and other stuff

## _treesitter_

syntax highlighting mainly but also more motions and stuff
