sudo dnf upgrade

# Enable RPM fusion https://rpmfusion.org/Configuration
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install rpmfusion-nonfree-release-tainted
# https://rpmfusion.org/keys

# Enable wifi
sudo dnf install b43-firmware broadcom-wl
# Sign into Wifi

sudo dnf install buildah firefox-wayland gnome-tweaks podman vim fedora-workstation-repositories flatpak-spawn

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
cp /usr/share/vim/vim81/vimrc_example.vim ~/.vimrc

ssh-keygen

# make a dev container
mkdir -p ~/Projects
image_id="$(podman image build -f dev-box.dockerfile . | tee >(cat 1>&2) | tail -n1 | awk '{print $NF}')"
podman container create --name dev-container -v ~/Projects:/root/projects:Z -v ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:Z -p 127.0.0.1:3022:3022 "$image_id"

cat > ~/.ssh/config << CONFIG
Host dev-container
  HostName localhost
  User root
  Port 3022
CONFIG
chmod 600 ~/.ssh/config

# start the dev-container
podman container start dev-container