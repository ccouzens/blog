# install with disk encryption

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify flathub --enable

flatpak install flathub com.valvesoftware.Steam org.gnome.PasswordSafe com.visualstudio.code
flatpak install fedora org.gimp.GIMP org.gnome.Epiphany org.gnome.gitg org.libreoffice.LibreOffice

mkdir -p ~/.local/bin/
printf '#!/usr/bin/env bash\nflatpak run org.gimp.GIMP "$@"\n' > ~/.local/bin/gimp
printf '#!/usr/bin/env bash\nflatpak run org.gnome.gitg "$@"\n' > ~/.local/bin/gitg
chmod +x ~/.local/bin/{gimp,gitg}

mkdir -p ~/Documents/github.com/owtaylor/
git -C ~/Documents/github.com/owtaylor/ clone https://github.com/owtaylor/toolbox-vscode.git
ln -s ~/Documents/github.com/owtaylor/toolbox-vscode/code.sh ~/.local/bin/code

# enable the google chrome repo in software
rpm-ostree install google-chrome-stable vim mozilla-openh264 virt-manager libvirt

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
# add places menu bar
gsettings set org.gnome.shell disabled-extensions "['background-logo@fedorahosted.org', 'window-list@gnome-shell-extensions.gcampax.github.com']"
gsettings set org.gnome.shell enabled-extensions "['apps-menu@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com']"
# setup dark theme
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# set up autologin

# Unselect this setting in vscode
# editor.selectionClipboard

toolbox create
toolbox run bash -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'

echo 'rpm-ostree upgrade; toolbox run sudo dnf upgrade -y; flatpak upgrade ; toolbox run \~/.cargo/bin/rustup update' > ~/.local/bin/laptop-update
chmod +x ~/.local/bin/laptop-update
