# Image to use to debug issues requiring specific versions.
#
# May need to increase max number of open files before building
# sudo ulimit -n 65536 && sudo ulimit -u 65536
#
# Build with `podman image build -f brew-container.dockerfile -t brew-container --ulimit nofile=65535:65535 .`.
# Run with `podman container run --rm -it -v "${HOME}/Documents/github.com/:/var/github:rw,z" brew-container`
FROM docker.io/ubuntu
RUN useradd -m -s /bin/bash linuxbrew && \
    usermod -aG sudo linuxbrew &&  \
    mkdir -p /home/linuxbrew/.linuxbrew && \
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
RUN apt-get update && apt-get install build-essential curl git libclang-dev --assume-yes
USER linuxbrew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew \
  HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar \
  HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew/Homebrew \
  PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN brew install leptonica llvm rust rustup-init tesseract
USER root
