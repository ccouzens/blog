FROM docker.io/fedora:33

RUN dnf install -y \
autoconf \
automake \
bash-completion \
bind-utils \
clang \
clippy \
cmake-filesystem \
gcc \
gcc-c++ \
git \
gtk3-devel \
java-latest-openjdk \
libgpg-error-devel \
libxml2-devel \
libxslt-devel \
make \
nodejs-yarn \
npm \
openssh-server \
procps \
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
xorg-x11-xauth \
xz-devel \
zlib-devel

RUN gem install \
puma \
rails \
sassc \
sqlite3

RUN git config --global user.email "ccouzens@gmail.com" && \
git config --global user.name "Chris Couzens" && \
git config --global core.editor "vim"

RUN ssh-keygen -A

CMD /usr/sbin/sshd -D -p 3022 -e
