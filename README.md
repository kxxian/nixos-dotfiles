# NixOS dotfiles

## Manage your configs using home-manager and flakes

create new directory for config files <br>

```bash
mkdir config
```

then clone your configs in that directory, then rebuild. <br>

## Add symlink to the config directory in your home user directory

```bash
ln -sf ~/nixos-dotfiles/config/
```

Note: don't forget to change the UUID's in hardware configuration before rebuilding it, if you're reinstalling it into a new machine. <br>

to check check the UUID's simply type. <br>

```bash
lsblk -f
```

## Wallpapers

create a new directory for wallpapers and copy the image in walls directory. <br>

in your home user directory, do this. <br>

```bash
mkdir ~/.wallpapers
cp ~/nixos-dotfiles/walls/* ~/.wallpapers
```

## Enable auto garbage collector

just simply run this in your terminal. <br>

```bash
systemctl start nix-gc.service
```
