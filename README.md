# im using nixos now

![default nixos gnome screenshot i just took](https://github.com/GravityShark0/nix/blob/83b2c1b262985569411d3a4c544031521a2099d3/assets/Screenshot%20from%202024-11-22%2018-46-39.png)

preferrably you wanna do this

> git config --local include.path ../.gitconfig

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

```bash
git clone --recurse-submodules --shallow-submodules git@github.com:GravityShark0/nix.git ~/.nix
nix flake update --flake ~/.nix
sudo nixos-rebuild boot --flake ~/.nix
home-manager boot --flake ~/.nix\?submodules=1
```

2. gentoo
   follow this one
   [https://wiki.gentoo.org/wiki/User:Alxhr0/Nix_on_openrc](https://wiki.gentoo.org/wiki/User:Alxhr0/Nix_on_openrc)

- note: some git configurations you might wanna enable

there are still some shits that needs to be installed non declaratively (which sucks)
more in [dump/README.md](dump/README.md)

## things i might look out for

- in gentoo they have [etckeeper](https://wiki.gentoo.org/wiki/Etckeeper)

```

```
