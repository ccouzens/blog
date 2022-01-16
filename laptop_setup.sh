sudo dnf upgrade

# Enable RPM fusion https://rpmfusion.org/Configuration
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install rpmfusion-nonfree-release-tainted
# https://rpmfusion.org/keys

sudo dnf install buildah firefox-wayland f*-backgrounds-gnome f*-backgrounds-extras-gnome gnome-tweaks podman vim fedora-workstation-repositories flatpak-spawn toolbox

sudo dnf groupupdate core
sudo dnf groupupdate multimedia
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.valvesoftware.Steam org.gimp.GIMP org.gnome.PasswordSafe org.gnome.gitg com.visualstudio.code

mkdir -p ~/.local/bin/
printf '#!/usr/bin/env bash\nflatpak run org.gimp.GIMP "$@"\n' > ~/.local/bin/gimp
printf '#!/usr/bin/env bash\nflatpak run org.gnome.gitg "$@"\n' > ~/.local/bin/gitg
printf '#!/usr/bin/env bash\nflatpak run com.visualstudio.code "$@"\n' > ~/.local/bin/code
chmod +x ~/.local/bin/{gimp,gitg,code}

# chrome
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install google-chrome

# Sign into Firefox
# Sign into Chrome
# Sign into Github
# Sign into Steam

git config --global user.name "Chris Couzens"
git config --global user.email "ccouzens@gmail.com"
git config --global core.editor vim
cp /usr/share/vim/vim82/vimrc_example.vim ~/.vimrc

ssh-keygen

# sign into github and clear up old keys
# https://github.com/settings/keys

gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
# disable middle click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste "false"
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click "true"
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
# alt tab behaviour
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"


# make a dev vm
mkdir -p ~/Documents/git/github.com/ccouzens
git -C ~/Documents/git/github.com/ccouzens clone git@github.com:ccouzens/dev-vm.git
echo 'exec ~/Documents/git/github.com/ccouzens/dev-vm/dev-vm.bash "$@"' > ~/.local/bin/dev-vm
chmod +x ~/.local/bin/dev-vm
# Follow the instructions about editing ~/.ssh/config
~/Documents/git/github.com/ccouzens/dev-vm/install-host.bash

# Manually connect to the dev-container after installing the ssh extension
code --install-extension ms-vscode-remote.remote-ssh

# Unselect this setting in vscode
# editor.selectionClipboard

echo 'rpm-ostree upgrade; toolbox run sudo dnf upgrade -y; flatpak upgrade ; toolbox run \~/.cargo/bin/rustup update' > ~/.local/bin/laptop-update
chmod +x ~/.local/bin/laptop-update
