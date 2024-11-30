# pumpnnix

my pumpndump but now im moving it to home manager cause why not

## shit that needs to be installed manually still even though its nix

1. doom emacs
   - [nix-doom-emacs](https://github.com/nix-community/nix-doom-emacs) is broken so you have to install it manually
   - from [doomemacs/doomemacs](https://github.com/doomemacs/doomemacs/tree/master?tab=readme-ov-file#install)

```sh
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install
```

2. ssh gnupg and password-store
   - duh i dont want my passwords be open to the public
   ```sh
   git clone gravity@clr:Git/password-store.git ~/.password-store
   git clone gravity@clr:Git/ssh.git ~/.config
   git clone gravity@clr:Git/gnupg.git ~/.gnupg
   ```
3. fonts for somereason need some little bit of shittery to fix every time you update it

```bash
fc-cache -f
```
