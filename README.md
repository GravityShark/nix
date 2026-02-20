# im using nixos now

- 2025 - fake monochrome
  - ![non default nixos niri screenshot i just took](assets/Screenshot%20from%202025-12-30%2015-18-13.png)
- 2024 - default gnome light
  - ![default nixos gnome screenshot i just took](assets/Screenshot%20from%202024-11-22%2018-46-39.png)

## resources im using

- looking stuff up
  - [NixOS Search](https://search.nixos.org)
  - [MyNixOS](https://mynixos.com/)
  - [google](https://www.google.com/) or
    [whatever privacy oriented search engine](https://search.brave.com)
- learning about nixos
  - [NixOS tutorial by LibrePhoenix](https://www.youtube.com/watch?v=6WLaNIlDW0M&list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG)
  - NixOS tutorials by [Vimjoyer](https://www.youtube.com/@vimjoyer)
    - there is nixos-rebuild --upgrade

> probably where my entire dotfiles is gonna reside from now on, even for non
> nixos systems

## file stcrcuture

```
nix
├╴assets
├╴dump
├╴home
├╴hosts
└╴nixos
```

- assets: just extra stuff like pictures
- dump: impure dotfiles (yuck!)
- home: home-manager related modules
- hosts: where you enable or disable modules per host
- nixos: nixos related modules

- i recommend just going to `flake.nix` and use `gf` in vim to follow links to
  understand what is going on

## installation

1. install nixos from the gui setting up the partitions (preferably swap
   partition) n reboot

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
   - you might want to shell into this first: a. git b. home-manager

```bash
git clone --recurse-submodules --shallow-submodules https://github.com/GravityShark/nix.git ~/.nix
```

- Might wanna copy the hardware config over
  (`cp /etc/nixos/hardware-configuration.nix ~/.nix/hosts/<YOUR_HOST>/hardware-configuration.nix`)

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

cd ~/.nix/dump/.config/nvim/
git switch master
git config --local include.path ../../../../../dump/.config/nvim/.gitconfig
```

n ur done, jus complete this [checklist](./dump/README.md) for stuff that isn't
declarative then reboot

## maintaining the system

1. for updating use `updatescript`
2. for cleaning up use `ngc` (abbrevation of nix garbage collect)
3. if you want te explore go into flake.nix and just use `gf` on any file you
   can see

## future ventures

1. [quickshell](https://quickshell.outfoxxed.me/) seems to be goated, if added
   with like a very minimal window manager
   https://github.com/AvengeMedia/DankMaterialShell
   - alternatives are:
     [Astal](https://aylur.github.io/astal/)/[AGS](https://aylur.github.io/ags/),
     [fabric](https://wiki.ffpy.org/),
     [Ignis](https://ignis-sh.github.io/ignis/stable/index.html),
     [ewww](https://github.com/elkowar/eww),
     [quickshell](https://quickshell.org/) and probably even more
   - not shells but good bars: [ironbar](https://crates.io/crates/ironbar),
     [waybar](https://github.com/Alexays/Waybar),
     [nwg-panel](https://github.com/nwg-piotr/nwg-panel)
   - alternative launcher would either be fuzzel if you want to have icons, or
     tofi to be blazingly fast
     - check out [raffi](https://github.com/chmouel/raffi)
2. turn [caprine-ng](https://github.com/Alex313031/caprine-ng) into a flake
   because it's the only working caprine fork for me
   - [this could be a good base](https://github.com/NixOS/nixpkgs/blob/fe51d34885f7b5e3e7b59572796e1bcb427eccb1/pkgs/by-name/ca/caprine-bin/package.nix#L10)
3. create your own window manager using [dwl](https://codeberg.org/dwl/dwl)
   - dwl is no longer maintanied
   - my ideal setup would probably be something like 1 application per
     tag/workspace. each new application open in a new tag automatically, also
     you auto focus on it. but new windows of the same application stay floating
     if it wants to be floating or just tiled on the same tag.
   - the start menu must be powerful, can get emojis, calculator, settings, file
     indexing allathat
   - not necessary but i would like shortcuts to open like the same top right
     menu for gnome, and also have the same top right menu as gnoem
   - i would also like to have a way to combine tags temporarily, like if you
     want to dual screen your browser and terminal you can select it and when
     you go away and return its gonna be gone - or semi permanently by just m
     oving the windows to the same tag - to reverse there should be another
     shortcut to move the current selected window int oa new workspace
   - the most important issues i dont know how to solve are:
     1. how would i be able to switch to tags efficiently
        - lowkey i forgot i have run or raise
4. maybe replace joshuto cause it sucks and doesn't work within tmux, and also
   also its really slow for some reason
   - probably with [yazi](https://github.com/sxyazi/yazi)
   - im gonna try using oil.nvim
     - oil really works tbh
     - the only 3 things that is missing oil for me
       1. follow tree view (fyler could work but buggy rn)
       2. exit cd, but its all good
       3. [default file manager](http://askubuntu.com/questions/84929/ddg#335911)
          and as
          [file chooser](https://github.com/hunkyburrito/xdg-desktop-portal-termfilechooser)
5. remove emacs for obsidian/obsi
   - obsidian sucks for task management, might try super productivity for this
   - i think its working
6. add [ tmuxifier ](https://github.com/jimeh/tmuxifier) for tmux layouts, or
   wait for sesh to update
7. new browser
   - vieb (electron)
   - vimb (webkit2gtk)
   - wyeb (webkit2gtk, 2months ago, ment to be used like suckless' surf)
   - with tabbed
   - qutebrowser (qtwebengine)
   - luakit (webkit2gtk, 10 months ago, broke last time i used it)
   - the main hurdle is that i really like mozilla sync, so i need an
     alternative
   - and also zen browser works really well, ((just need to theme it right))
8. KDE Connect
9. probably the next step down the slippery slope is removing systemd, with like
   guixsd or nixng or notos or six-os
   - nvm guix is so UN supported bruh
   - alternatives to nixos reproducibility/repeatability
     1. https://github.com/numtide/system-manager uses nix, works on any distro
     2. https://gitlab.com/Oglo12/rebos does NOT use nix, works on any distro
     3. distrobox on nixos.
     4. ansible playbook
     5. just good ol bash scripts
     6. chezmoi is interesting, it can do passwords
10. use [stylix](https://nix-community.github.io/stylix/)
    - [ ] support other applications
      - [ ] youtube-music
      - [ ] super productivity
      - [ ] caprine
11. pls fix this, otherwise we gonna use superproductivity instead
    https://github.com/CCExtractor/taskwarrior-flutter/issues/382
    - superprod got mkdwn plugins
    - maybe get rid of obsidian
12. other window managers
    - hyprland (just for the maximum support, that isn't gnome or kde)
    - mango (maybe second to hyprland, also supports tags like river)
    - river (to make my own wayland compositor)
13. [x] make ppd-dbus-hook a flake
    - [x] use tlp 1.9 when it comes out on nixpkgs and use it instead of tuned
14. make a personal setup for gpu-screen-recorder instead of using the noctalia
    extension https://git.dec05eba.com/gpu-screen-recorder/about/
15. checkout [gradia](https://github.com/AlexanderVanhee/Gradia) and
    [satty](https://github.com/Satty-org/Satty) for better screensots
16. [supergfxctl](https://gitlab.com/asus-linux/supergfxctl) gpu mode and vfio
17. start reading RSS and use this https://noctalia.dev/plugins/rss-feed/
18. add a search tool in noctalia-shell like this
    https://noctalia.dev/plugins/kagi-quick-search/
19. add duplication of monitors
20. Use a declarative flatpak on nix instead
    [declarative-flatpak](https://github.com/in-a-dil-emma/declarative-flatpak)
    [nix-flatpak](https://github.com/gmodena/nix-flatpak)
21. Instead of using stylix, use noctalia, with matugen, or create styles to
    use. but use noctalia templates instead so that it can live reload itself
22. Use tmpfs on minecraft, or impermanence
23. Install [impurity.nix](https://github.com/outfoxxed/impurity.nix) to link
    testing
