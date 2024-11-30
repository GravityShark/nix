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
nix flake update ~/.nix
doas nixos-rebuild switch --flake ~/.nix
home-manager switch --flake ~/.nix
```

stuff with git

```bash
git config --local include.path ../.gitconfig
```

there are still some shits that needs to be installed non declarativel
more in [dump/README.md](dump/README.md)

## things i might look out for

- in gentoo they have [etckeeper](https://wiki.gentoo.org/wiki/Etckeeper)
