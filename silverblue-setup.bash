# install with disk encryption

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify flathub --enable

flatpak install flathub com.valvesoftware.Steam com.github.flxzt.rnote org.chromium.Chromium flathub com.belmoussaoui.Decoder io.github.pwr_solaar.solaar
flatpak install fedora org.gimp.GIMP org.gnome.Epiphany org.gnome.gitg org.libreoffice.LibreOffice org.gnome.World.Secrets

mkdir -p ~/.local/bin/

rpm-ostree override remove noopenh264 \
--install openh264 \
--install mozilla-openh264 \
--install vim \
--install virt-manager \
--install libvirt \
--install helix \
--install wl-clipboard \
--install android-tools \
--install steam-devices \
--install solaar-udev \
--install google-chrome

git config --global user.name "Chris Couzens"
git config --global user.email "ccouzens@gmail.com"
git config --global core.editor hx
cp /usr/share/vim/vim*/vimrc_example.vim ~/.vimrc

ssh-keygen

# sign into github and clear up old keys
# https://github.com/settings/keys
# setup ssh key fingerprints
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints
cat >> ~/.ssh/known_hosts <<< ''

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
toolbox run sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
toolbox run sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
toolbox run dnf check-update
toolbox run sudo dnf install code
toolbox run sudo dnf install gitg rustup helix wl-clipboard make clang gcc nodejs-npm pnpm clang-tools-extra rust-lldb wabt android-tools golang golang-x-tools-gopls golang-x-tools-goimports swift-lang swiftlint
toolbox run rustup-init -y
toolbox run rustup component add rust-analyzer
toolbox run npm config set "prefix=$HOME/.local"
toolbox run pnpm setup
toolbox run pnpm install -g typescript typescript-language-server vscode-langservers-extracted dockerfile-language-server-nodejs svelte-language-server typescript-svelte-plugin
toolbox run cargo install pest-language-server

printf '#!/usr/bin/env bash\ntoolbox run /usr/bin/code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland "$@"\n' > ~/.local/bin/code
chmod +x ~/.local/bin/code

# Unselect this setting in vscode
# editor.selectionClipboard

mkdir -p ~/.config/helix/
cat > ~/.config/helix/config.toml <<< '[editor.soft-wrap]
enable = true

[editor]
auto-pairs = false 

[editor.lsp]
display-inlay-hints = true
'

echo 'toolbox run sudo dnf upgrade -y; flatpak upgrade --assumeyes ; toolbox run \~/.cargo/bin/rustup update; rpm-ostree upgrade' > ~/.local/bin/laptop-update
chmod +x ~/.local/bin/laptop-update

### Set up remote phone debugging
# roughly following https://forums.fedoraforum.org/showthread.php?298965-HowTo-set-up-adb-(Android-Debug-Bridge)-on-Fedora-20

# first device jelly star
# second device s22
sudo tee /etc/udev/rules.d/99-android-debug.rules <<< 'SUBSYSTEM=="usb", ATTR{idVendor}=="0e8d", ATTR{idProduct}=="201c", GROUP="chris", MODE="0664"
SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", ATTR{idProduct}=="6860", GROUP="chris", MODE="0664"'
# adb reverse tcp:8080 tcp:8080

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
