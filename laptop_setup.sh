sudo dnf upgrade

# Enable RPM fusion https://rpmfusion.org/Configuration
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install rpmfusion-nonfree-release-tainted
# https://rpmfusion.org/keys

sudo dnf install buildah firefox-wayland f*-backgrounds-gnome f*-backgrounds-extras-gnome gnome-tweaks podman vim fedora-workstation-repositories flatpak-spawn

sudo dnf groupupdate core
sudo dnf groupupdate multimedia
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.valvesoftware.Steam org.gimp.GIMP org.gnome.PasswordSafe org.gnome.gitg com.visualstudio.code

mkdir -p ~/.local/bin/
echo 'flatpak run org.gimp.GIMP "$@"' > ~/.local/bin/gimp
echo 'flatpak run org.gnome.gitg "$@"' > ~/.local/bin/gitg
echo 'flatpak run com.visualstudio.code "$@"' > ~/.local/bin/code
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

# make a dev vm
mkdir -p ~/Documents/git/github.com/ccouzens
git -C ~/Documents/git/github.com/ccouzens clone git@github.com:ccouzens/dev-vm.git
echo 'exec ~/Documents/git/github.com/ccouzens/dev-vm/dev-vm.bash "$@"' > ~/.local/bin/dev-vm
chmod +x ~/.local/bin/dev-vm
# Follow the instructions about editing ~/.ssh/config
~/Documents/git/github.com/ccouzens/dev-vm/install-host.bash

# Manually connect to the dev-container after installing the ssh extension
code --install-extension ms-vscode-remote.remote-ssh

echo 'sudo dnf upgrade -y; flatpak upgrade ; dev-vm dnf upgrade -y ; dev-vm /home/vagrant/.cargo/bin/rustup update' > ~/.local/bin/laptop-update
chmod +x ~/.local/bin/laptop-update
