FROM docker.io/fedora:33

RUN dnf install -y \
clippy \
cmake-filesystem \
gcc \
gcc-c++ \
git \
libgpg-error-devel \
libxml2-devel \
libxslt-devel \
make \
nodejs-yarn \
npm \
redhat-rpm-config \
rls \
ruby \
ruby-devel \
rust \
rust-analysis \
rust-gdb \
rust-src \
rustfmt \
sqlite \
sqlite-devel \
vim \
xz-devel \
zlib-devel

RUN gem install \
puma \
rails \
sassc \
sqlite3
