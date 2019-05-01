sudo dnf upgrade

sudo dnf install akmod-wl kmod-wl broadcom-wl

sudo dnf install buildah firefox-wayland gnome-tweaks nodejs-yarn npm podman nautilus-dropbox

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.valvesoftware.Steam io.atom.Atom org.gimp.GIMP org.gnome.PasswordSafe org.gnome.gitg com.visualstudio.code

echo 'flatpak run io.atom.Atom "$@"' > ~/.local/bin/atom
echo 'flatpak run org.gimp.GIMP "$@"' > ~/.local/bin/gimp
echo 'flatpak run org.gnome.gitg "$@"' > ~/.local/bin/gitg
echo 'flatpak run com.visualstudio.code "$@"' > ~/.local/bin/code
chmod +x ~/.local/bin/{atom,gimp,gitg,code}

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# Install https://www.google.com/chrome/
# Install https://www.dropbox.com/install
# Install https://exercism.io/cli to ~/.local/bin/exercism

# Sign into Firefox
# Sign into Chrome
# Sign into Dropbox
# Sign into Github
# Sign into Steam
# Sign into Wifi
