# Instalar o Arch Linux no meu laptop

## Conexão com a Internet
### Primeiro, se você não souber o nome do seu dispositivo sem fio, liste todos os dispositivos Wi-Fi:
``` 
iwctl
device list
``` 
### Em seguida, para procurar redes:
``` 
station wlan0 scan
``` 
### Você pode listar todas as redes disponíveis:
``` 
station wlan0 get-networks
``` 
### Por fim, para conectar-se a uma rede:
``` 
station wlan0 connect SSID
``` 
### Se uma senha for necessária, você será solicitado a digitá-la. Como alternativa, você pode fornecer como argumento da linha de comando:
``` 
iwctl station wlan0 connect SSID
``` 
### Atualize o relógio do sistema.
``` 
timedatectl set-ntp true 
``` 
## Formatando o disco

### Formatar a partição sda1 (/root)
``` 
mkfs.ext4 -L ROOT /dev/sda1
``` 
### Ativar a partição SWAP
``` 
mkswap  -L SWAP /dev/sda2
swapon /dev/sda2
``` 
### Formatar a partição sda3 (/home)
``` 
mkfs.ext4 -L HOME /dev/sda3
``` 

## Montagem das partições

### Montagem da partição root e home
``` 
mount /dev/sda1 /mnt

mkdir /mnt/home

mount /dev/sda3 /mnt/home
``` 
## Instalar os pacotes base do Arch Linux
``` 
pacstrap -i /mnt base base-devel linux linux-firmware nano dhcpcd
``` 
## Configurar fstab

### Para configurar fstab (tabela de sistemas de arquivos) execute:
``` 
genfstab -U  /mnt >> /mnt/etc/fstab
``` 
### Agora é hora de mudar para o diretório root recém-instalado para configurá-lo.
``` 
arch-chroot /mnt 
``` 
## Configurações de idioma e fuso horário


### Para configurar o idioma do sistema, execute o seguinte comando:
``` 
sed -i  '/en_US.UTF-8/,+1 s/^#//' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
export LANG=en_US.UTF-8 
``` 
### Agora você pode configurar a sua zona:
``` 
ln -sf /usr/share/zoneinfo/America/Sao_Paulo  /etc/localtime
``` 
## Configurar o repositório

### Com este comando habilitamos o repositório multlib:
``` 
sed -i  '/multilib\]/,+1  s/^#//'  /etc/pacman.conf
pacman -Sy
``` 
## Defina seu nome de host
``` 
echo nin > /etc/hostname
``` 
## Alterar DNS:

``` 
nano /etc/resolv.conf 
``` 
    nameserver 8.8.8.8

    nameserver 8.8.4.4

## Configurando a Conexão 
``` 
systemctl enable dhcpcd (rede cabeada)
``` 
## Wifi ( Instalar componentes wifi )
``` 
pacman -S wpa_supplicant dialog iw networkmanager 

systemctl enable NetworkManager
``` 
## Criar Usuário (s)


### useradd -m -g [initial_group] -G [additional_groups] -s [login_shell] [username] 
``` 
useradd -m -g users -G log,sys,wheel,rfkill,dbus -s /bin/bash username
passwd username
passwd
pacman -S bash-completion
sed -i '/%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers
``` 

## Instalar e configurar o boot-loader ( BIOS  )
``` 
mkinitcpio -P
pacman -S grub
grub-install --target=i386-pc --recheck /dev/sda
pacman -S intel-ucode ( Se você tiver uma CPU Intel, instale o pacote intel-ucode )
grub-mkconfig -o /boot/grub/grub.cfg
``` 
## Desmontar as partições e reiniciar:
``` 
exit
umount -R /mnt
reboot
``` 

## Install Display Server
``` 
pacman -S xorg-server xorg-xinit  xorg-apps gvfs-mtp  
``` 

## Install Graphics Driver
```
pacman -S xf86-video-intel
```
## Install ALSA
```
pacman -S alsa-utils pulseaudio pavucontrol alsa-oss alsa-lib
```
## Display Manager ou Login Manager
```
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm.service  
```
## Colocando as pastas de usuários
```
pacman -S xdg-user-dirs
xdg-user-dirs-update
```
## Drivers do touchpad
```
pacman -S xf86-input-libinput
```
## Advanced Configuration and Power Interface
```
pacman -S acpi acpid 
```
## Install terminal
```
pacman -S rxvt-unicode
```
## Install thunar
```
pacman -S thunar
```
## Install git
```
pacman -S git
```

## Git clone no meu repositorio (usar o usurio nao root)
```
cd Documents
git clone https://github.com/0xFr3shPr1nc3/Dotfiles.git
```

## Install and config WM e seu amigo Sxhkd
```
pacman -S bspwm sxhkd
mkdir .config/bspwm
mkdir .config/sxhkd
cp Documents/Dotfiles/.config/bspwm/* .config/bspwm/
cp Documents/Dotfiles/.config/sxhkd/sxhkdrc .config/sxhkd/
cp Documents/Dotfiles/.xinitrd /home/$USER/.xinitrd
```
## Install rofi and dunst
```
pacman -S rofi dunst
mkdir .config/dunst
mkdir .config/rofi (caso nao tenha)
cp Documents/Dotfiles/.config/dunst/* .config/dunst/
cp Documents/Dotfiles/.config/rofi/* .config/rofi/
```
## Arch User Repository
```
echo -e "[archlinuxfr]\nSigLevel = Never\nServer=http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
pacman -Sy
git clone https://aur.archlinux.org/trizen.git
cd trizen-git
makepkg -si
```
## Install polybar
```
trizen -S polybar
mkdir .config/polybar
cp Documents/Dotfiles/.config/polybar/* .config/polybar/
```
## Config urxvt terminal
```
cp Documents/Dotfiles/.Xresources /home/$USER/.Xresources
```
## Put all fonts for polybar/terminal and zsh
```
cp Documents/Dotfiles/.fonts/* /home/$USER/.fonts/
```
## Install zsh and oh-my-zsh
```
pacman -S zsh curl
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp Documents/Dotfiles/.zshrc /home/$USER/.zshrc
cp Documents/Dotfiles/daivasmara.zsh-theme /home/$USER/.oh-my-zsh/custom/themes/ 
sudo usermod --shell /bin/zsh $USER
```

## Install lightdm-webkit
```
trizen-S lightdm-webkit-theme-aether
```
## Install spotify
```
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
trizen -S spotify
```
##  Acaba aqui pode dar o Reboot