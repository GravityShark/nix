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

````bash

git clone --recurse-submodules --shallow-submodules https://github.com/GravityShark/nix.git ~/.nix
nix flake update --flake ~/.nix
sudo nixos-rebuild boot --flake ~/.nix
home-manager switch --flake ~/.nix\?submodules=1
````

setup git

```bash
cd ~/.nix
git config --local include.path ../.gitconfig

# also setup neovim

cd ~/.nix/home/dump/.config/nvim/
git switch master
```

n ur done, jus complete this checklist

- [-] change the scaling to 150%
- [ ] sync the browser, and extensions
- [ ] [reinstall doomemacs](./home/dump/README.md)
- [ ] re sync anki
- [ ] re sync syncthing
- [ ] login back to the various applications
- [ ] Redownload and setup some wallpapers or something

there are still some shits that needs to be installed non declaratively (which sucks)
more in [home/dump/README.md](home/dump/README.md)

