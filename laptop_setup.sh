sudo dnf upgrade

# Enable RPM fusion https://rpmfusion.org/Configuration
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install rpmfusion-nonfree-release-tainted
# https://rpmfusion.org/keys

# Enable wifi
sudo dnf install b43-firmware broadcom-wl
# Sign into Wifi

sudo dnf install buildah firefox-wayland gnome-tweaks nodejs-yarn npm podman vim fedora-workstation-repositories

sudo dnf groupupdate core
sudo dnf groupupdate multimedia
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.valvesoftware.Steam io.atom.Atom org.gimp.GIMP org.gnome.PasswordSafe org.gnome.gitg com.visualstudio.code

echo 'flatpak run io.atom.Atom "$@"' > ~/.local/bin/atom
echo 'flatpak run org.gimp.GIMP "$@"' > ~/.local/bin/gimp
echo 'flatpak run org.gnome.gitg "$@"' > ~/.local/bin/gitg
echo 'flatpak run com.visualstudio.code "$@"' > ~/.local/bin/code
chmod +x ~/.local/bin/{atom,gimp,gitg,code}

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rustfmt clippy rls rust-analysis rust-src
code --install-extension rust-lang.rust
# Set rustup path in visual studio code to /home/chris/.cargo/bin/rustup

# chrome
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install google-chrome

# Install exercism
curl -L https://github.com/exercism/cli/releases/download/v3.0.11/exercism-linux-64bit.tgz | tar -C ~/.local/bin/ -xzvf - ./exercism
# https://exercism.io/my/settings
# exercism configure --token=YOUR_API_TOKEN

# Install Intellij IDEA
mkdir -p ~/.local/opt/idea
curl https://download-cf.jetbrains.com/idea/ideaIC-2019.1.3.tar.gz | tar -C ~/.local/opt/idea -xzvf -
echo '~/.local/opt/idea/idea-IC-191.7479.19/bin/idea.sh "$@"' > ~/.local/bin/idea
chmod +x ~/.local/bin/idea

# Sign into Firefox
# Sign into Chrome
# Sign into Github
# Sign into Steam

git config --global user.name "Chris Couzens"
git config --global user.email "ccouzens@gmail.com"
git config --global core.editor vim
cp /usr/share/vim/vim81/vimrc_example.vim ~/.vimrc
