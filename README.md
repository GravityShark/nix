# im using nixos now

![default nixos gnome screenshot i just took](https://github.com/GravityShark/nix/blob/83b2c1b262985569411d3a4c544031521a2099d3/assets/Screenshot%20from%202024-11-22%2018-46-39.png)

## resources im using

- looking stuff ub
  - [NixOS Search](https://search.nixos.org)
  - [MyNixOS](https://mynixos.com/)
  - [google](https://www.google.com/) or [whatever privacy oriented search engine](https://search.brave.com)
- learning about nixos
  - [NixOS tutorial by LibrePhoenix](https://www.youtube.com/watch?v=6WLaNIlDW0M&list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG)

> probably where my entire dotfiles is gonna reside from now on
> even for non nixos systems

## installation

> assuming that you like use the same user name (gravity)

1. install nixos from the gui setting up the partitions (preferably swap partition n reboot.

2. now when you're in, enable flake capabilities

```nix
#/etc/nixos/configuration.nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

then run

```bash
sudo nixos-rebuild switch
```

3. clone this nix config

```bash
git clone --recurse-submodules --shallow-submodules https://github.com/GravityShark/nix.git ~/.nix
```

- Might wanna copy the hardware config over (`cp /etc/nixos/hardware-configuration.nix ~/.nix/system/hardware-configuration.nix`)

4. then update

```bash
nix flake update --flake ~/.nix
sudo nixos-rebuild switch --flake ~/.nix
home-manager switch --flake ~/.nix\?submodules=1
```

5. setup git so that you can push new changes easily

```bash
cd ~/.nix
git config --local include.path ../.gitconfig

# also setup neovim

cd ~/.nix/home/dump/.config/nvim/
git switch master
git config --local include.path ../../../../../home/dump/.config/nvim/.gitconfig
```

n ur done, jus complete this checklist then reboot

- [ ] sync the browser, and [extensions](./home/dump/README.md)
- [ ] [setup doom emacs](./home/dump/README.md)
- [ ] Redownload and setup some wallpapers or something
  - [Distrotube](https://gitlab.com/dwt1/wallpapers)
  - Rosepine ([1](https://github.com/rose-pine/wallpapers), [2](https://wallhaven.cc/tag/162505), or just [google](https://www.google.com/search?q=rose+pine+wallpaper&tbs=imgo:1&udm=2) [it](https://duckduckgo.com/?t=h_&q=rose+pine+wallpaper&ia=images&iax=images))

## maintaining the system

1. for updating use `updatescript`
   - For doom emacs just do a `doom env`, and if you want an actual update do `doom upgrade` (which already also does doom env) but you barely want to do this if it wokrs it wokrs type ish
   - if you are tryna build without internet, use the `--option substitute false` option for nixos-rebuild, and `--no-substitute` for home-manager
2. for cleaning up use `ngc` (abbrevation of nix garbage collect)
   - and also clean up doom emacs too `doom gc`

## future ventures

1. [quickshell](https://quickshell.outfoxxed.me/) seems to be goated, if added with like a very minimal window manager

2. turn [caprine-ng](https://github.com/Alex313031/caprine-ng) into a flake because it's the only working caprine fork for me
   - [this could be a good base](https://github.com/NixOS/nixpkgs/blob/fe51d34885f7b5e3e7b59572796e1bcb427eccb1/pkgs/by-name/ca/caprine-bin/package.nix#L10)

3. create your own window manager using [dwl](https://codeberg.org/dwl/dwl)
   - probably the next step down the slippery slope is removing systemd, with like guixsd or nixng or notos or six-os
   - my ideal setup would probably be something like 1 application per
     tag/workspace. each new application open in a new tag automatically, also
     you auto focus on it. but new windows of the same application stay
     floating if it wants to be floating or just tiled on the same tag.
   - the start menu must be powerful, can get emojis, calculator, settings, file indexing allathat
   - not necessary but i would like shortcuts to open like the same top right
     menu for gnome, and also have the same top right menu as gnoem
   - i would also like to have a way to combine tags temporarily, like if you
     want to dual screen your browser and terminal you can select it and when you
     go away and return its gonna be gone - or semi permanently by just m oving
     the windows to the same tag - to reverse there should be another shortcut
     to move the current selected window int oa new workspace

   - the most important issues i dont know how to solve are:
     1. how would i be able to switch to tags efficiently
        - lowkey i forgot i have run or raise

4. maybe replace joshuto cause it sucks and doesn't work within tmux, and also
   also its really slow for some reason
   - probably with [yazi](https://github.com/sxyazi/yazi)
   - im gonna try using oil.nvim
     - oil really works tbh

5. remove emacs for obsidian/obsi

6. add [ tmuxifier ](https://github.com/jimeh/tmuxifier) for tmux layouts, or wait for sesh to update

7. new browser
   - vieb (electron)
   - vimb (webkit2gtk)
   - wyeb (webkit2gtk, 2months ago, ment to be used like suckless' surf)
   - with tabbed
   - qutebrowser (qtwebengine)
   - luakit (webkit2gtk, 10 months ago, broke last time i used it)
   - the main hurdle is that i really like mozilla sync, so i need an alternative
