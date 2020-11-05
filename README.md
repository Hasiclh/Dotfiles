# Dotfiles

Here are my local dotfiles mainly including

* `bsp` as wm
* `code` as editor
* `urxvt` as terminal
* `rofi` as dmenu replacement
* `dunst` as notification deamon
* `polybar` as status bar


## List of programs
### Pacman
* xorg-server 
* xorg-xinit  
* xorg-apps 
* gvfs-mtp
* xf86-video-intel - para placas da Intel
* alsa-oss 
* alsa-lib
* pulseaudio 
* pavucontrol
* alsa-utils 
* lightdm 
* lightdm-gtk-greeter
* xdg-user-dirs
* acpi 
* acpid 
* xf86-input-libinput
* iwd
* git
* bspwm
* sxhkd
* urxvt (rxvt-unicode)
* rofi
* dunst
* zsh
* thunar
* opera
* discord
* telegram-desktop
* feh
* curl
* p7zip 
* unrar 
* tar 
* rsync 
* file-roller
* transmission-gtk

### AUR
* polybar
* spotify
* beautifuldiscord
* betterlockscreen


## Setting the Shell
You might also want to set your shell to `zsh` if you have it installed:
``` sh
sudo usermod --shell /bin/zsh $USER
```
## Instaling oh-my-zsh
``` sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## For instaling spotify you must need fix the GPG key issue by using:
``` sh
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
```
