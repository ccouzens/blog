# Copy Fedora IOT to an SD card. Use a command like so
sudo arm-image-installer \
"--image=$HOME/Downloads/Fedora-IoT-raw-43-20251024.0.aarch64.raw.xz" \
--target=rpi4 \
--media=/dev/sda \
--resizefs \
--addkey "$HOME/.ssh/id_ed25519.pub" \
--norootpass \
--wifi-ssid=*** \
--wifi-pass=***

useradd chris -G wheel
sudo passwd chris

sudo rpm-ostree install \
avahi \
bat \
clang \
clang-tools-extra \
cmake \
cockpit \
cockpit-machines \
cockpit-ostree \
cockpit-podman \
helix \
man-db \
man-pages \
ninja-build
nodejs-npm \
pnpm \
ripgrep \
rust-lldb \
rustup \
vim

sudo hostnamectl set-hostname --static raspberrypi4-iot
