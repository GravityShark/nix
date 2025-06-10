# im using nixos now

![default nixos gnome screenshot i just took](https://github.com/GravityShark/nix/blob/83b2c1b262985569411d3a4c544031521a2099d3/assets/Screenshot%20from%202024-11-22%2018-46-39.png)

## resources im using

- looking stuff up
  - [NixOS Search](https://search.nixos.org)
  - [MyNixOS](https://mynixos.com/)
  - [google](https://www.google.com/) or [whatever privacy oriented search engine](https://search.brave.com)
- learning about nixos
  - [NixOS tutorial by LibrePhoenix](https://www.youtube.com/watch?v=6WLaNIlDW0M&list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG)

> probably where my entire dotfiles is gonna reside from now on
> even for non nixos systems

## installation

> assuming that you like use the same user name (gravity) and also disk partitioning

1. install nixos from the gui setting up the partitions n reboot.


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

- Might wanna copy the hardware config over (`cp /etc/nixos/hardware-configuration.nix ~/.nix/system/hardware-configuration.nix`) and setup some [swap](https://nixos.wiki/wiki/Swap)

4. then update

```bash
nix flake update --flake ~/.nix
sudo nixos-rebuild boot --flake ~/.nix
home-manager switch --flake ~/.nix\?submodules=1
```

5. setup git so that you can push new changes easily

```bash
cd ~/.nix
git config --local include.path ../.gitconfig

# also setup neovim

cd ~/.nix/home/dump/.config/nvim/
git switch master
```

n ur done, jus complete this checklist then reboot

- [ ] sync the browser, and [extensions](./home/dump/README.md)
- [ ] [setup doom emacs](./home/dump/README.md)
- [ ] Redownload and setup some wallpapers or something
  - [Distrotube](https://gitlab.com/dwt1/wallpapers)
  - Rosepine ([1](https://github.com/rose-pine/wallpapers), [2](https://wallhaven.cc/tag/162505), or just [google](https://www.google.com/search?q=rose+pine+wallpaper&tbs=imgo:1&udm=2) [it](https://duckduckgo.com/?t=h_&q=rose+pine+wallpaper&ia=images&iax=images))

## maintaining the system

1. for updating use `updatescript`
   - For doom emacs just do a `doom env`, and if you want an actual update do `doom upgrade` but you barely want to do this if it wokrs it wokrs type ish
2. for cleaning up use `ngc` (abbrevation of nix garbage collect)
   - and also clean up doom emacs too `doom gc`

## future ventures

1. try to fix this [gnome extension that i really like](https://github.com/Favo02/workspaces-by-open-apps/issues/115)
