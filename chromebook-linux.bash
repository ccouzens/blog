sudo apt install wl-clipboard build-essential

# set password
sudo passwd chris

curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh > install.sh

# unset password
sudo passwd chris --delete

brew install helix rustup
rustup-init -y
rustup component add rust-analyzer

# other stuff from silverblue setup

# add `true-color = true` to `editor` section in helix config
