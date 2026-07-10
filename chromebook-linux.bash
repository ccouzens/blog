sudo apt install \
build-essential \
git \
hx \
podman \
rustup \
wl-clipboard

rustup-init -y
rustup component add rust-analyzer

# other stuff from silverblue setup

# add `true-color = true` to `editor` section in helix config
