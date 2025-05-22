# im using nixos now

![default nixos gnome screenshot i just took](https://github.com/GravityShark0/nix/blob/83b2c1b262985569411d3a4c544031521a2099d3/assets/Screenshot%20from%202024-11-22%2018-46-39.png)

## resources im using

- looking stuff up
  - [NixOS Search](https://search.nixos.org)
  - [MyNixOS](https://mynixos.com/)
  - [google](https://www.google.com/) or [whatever privacy oriented search engine](https://search.brave.com)
- learning about nixos
  - [NixOS tutorial by LibrePhoenix](https://www.youtube.com/watch?v=6WLaNIlDW0M&list=PL_WcXIXdDWWpuypAEKzZF2b5PijTluxRG)

> probably where my entire dotfiles is gonna reside from now on
> even for non nixos systems

### installation

1. nixos

install nixos from the gui setting up the partitions n reboot.

also add flake capabilities lol

```nix
#/etc/nixos/configuration.nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

```bash

sudo nixos-rebuild switch
```

get yo .ssh and .gnupg up then install it

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_*
chmod 644 ~/.ssh/id_*.pub
chmod 600 ~/.ssh/config
# chown -R $(whoami) ~/.gnupg/
# chmod 600 ~/.gnupg/*
# chmod 700 ~/.gnupg
```

then install it dimwit
also enable

```bash
git clone --recurse-submodules --shallow-submodules git@github.com:GravityShark0/nix.git ~/.nix
nix flake update --flake ~/.nix
sudo nixos-rebuild boot --flake ~/.nix
home-manager switch --flake ~/.nix\?submodules=1
```

setup git

```bash
cd ~/.nix
git config --local include.path ../.gitconfig

# also setup neovim

cd ~/.nix/home/dump/.config/nvim/
git switch master
```

n ur done, jus complete this checklist

- [ ] change the scaling to 150%
- [ ] sync the browser
  - unduck
- [ ] add youtubemusic and messenger as web apps
- [ ] reinstall doomemacs

```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

- [ ] re sync anki
- [ ] re sync syncthing
- [ ] setup authenticator
- [ ] login back to disc and other

2. gentoo
   follow this one
   [https://wiki.gentoo.org/wiki/User:Alxhr0/Nix_on_openrc](https://wiki.gentoo.org/wiki/User:Alxhr0/Nix_on_openrc)

- note: some git configurations you might wanna enable

there are still some shits that needs to be installed non declaratively (which sucks)
more in [home/dump/README.md](home/dump/README.md)

## things i might look out for

- in gentoo they have [etckeeper](https://wiki.gentoo.org/wiki/Etckeeper)

```

```
