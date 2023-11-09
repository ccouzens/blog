# install with disk encryption

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify flathub --enable

flatpak install flathub com.valvesoftware.Steam org.gnome.World.Secrets
flatpak install fedora org.gimp.GIMP org.gnome.Epiphany org.gnome.gitg org.libreoffice.LibreOffice

mkdir -p ~/.local/bin/
printf '#!/usr/bin/env bash\nflatpak run org.gimp.GIMP "$@"\n' > ~/.local/bin/gimp
printf '#!/usr/bin/env bash\nflatpak run org.gnome.gitg "$@"\n' > ~/.local/bin/gitg
chmod +x ~/.local/bin/{gimp,gitg}

# enable the google chrome repo in software
rpm-ostree install google-chrome-stable vim mozilla-openh264 virt-manager libvirt

git config --global user.name "Chris Couzens"
git config --global user.email "ccouzens@gmail.com"
git config --global core.editor vim
cp /usr/share/vim/vim*/vimrc_example.vim ~/.vimrc

ssh-keygen

# sign into github and clear up old keys
# https://github.com/settings/keys

gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
# disable middle click paste
gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing false
# alt tab behaviour
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"

# Repeat important config for login screen
machinectl shell gdm@ /bin/bash
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true


# Firefox
# about:config
# middlemouse.paste set to false
# clipboard.autocopy set to false
# browser.tabs.searchclipboardfor.middleclick to false

# set up autologin

toolbox create
toolbox run bash -c 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'
toolbox run sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
toolbox run sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
toolbox run dnf check-update
toolbox run sudo dnf install code
toolbox run sudo dnf copr enable varlad/helix
toolbox run sudo dnf install helix wl-clipboard make clang gcc nodejs-npm
toolbox run npm config set "prefix=$HOME/.local"

printf '#!/usr/bin/env bash\ntoolbox run /usr/bin/code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland "$@"\n' > ~/.local/bin/code
chmod +x ~/.local/bin/code

# Unselect this setting in vscode
# editor.selectionClipboard

mkdir -p ~/.config/helix/
cat > ~/.config/helix/config.toml <<< 'theme = "dark_high_contrast"

[editor.soft-wrap]
enable = true
'

cat > ~/.local/bin/hx <<< '#!/usr/bin/env bash
hx=/usr/bin/hx
if [[ -f "$hx" ]]; then
  exec "$hx" "$@"
else
  toolbox run "$hx" "$@"
fi
'
chmod +x ~/.local/bin/hx

echo 'toolbox run sudo dnf upgrade -y; flatpak upgrade --assumeyes ; toolbox run \~/.cargo/bin/rustup update; rpm-ostree upgrade' > ~/.local/bin/laptop-update
chmod +x ~/.local/bin/laptop-update


#####

ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub
sudo tee /etc/ssh/sshd_config.d/60-chris.conf <<< '
PasswordAuthentication no
PermitRootLogin no
'
sudo systemctl enable --now sshd

sudo tee /etc/avahi/services/ssh.service <<< '<?xml version="1.0" standalone="no"?>
<!DOCTYPE service-group SYSTEM "avahi-service.dtd">

<service-group>
  <name replace-wildcards="yes">%h</name>
  <service>
    <type>_ssh._tcp</type>
    <port>22</port>
  </service>
</service-group>
'
