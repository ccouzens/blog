# Developing in a container

06/12/2020

It has been more than a year since I wrote my other blog post. I am not yet in
the habbit of regular posts.

The modern development workflow is insecure. A typical Linux or Mac developer
has secrets in their home directory such as their browser cookies, browser
passwords and ssh keys. They will also run unverified code from the internet
when installing NPM packages, Cargo crates and Ruby Gems. In this setup, there
is no technical mechanism to prevent these packages from stealing the user's
secrets.

Most developers rely on the good will of other developers, and the hope that
other people will spot an attack first. Identified attacks are rare, but
[have happened](https://blog.npmjs.org/post/180565383195/details-about-the-event-stream-incident).

I believe the best defence is to install and run development packages in an
isolated environment that cannot access or overwrite any secrets. I've chosen to
isolate myself using a Podman (similar to Docker) container. If you want more
isolation you might chose to use a Virtual Machine or a separate physical
machine.

[GitHub Codespaces](https://github.com/features/codespaces) is a commercial
solution that totally isolates your dev environment from your laptop.

## My Setup

I ssh into a local container. I run Visual Studio Code outside of the container,
but have it connect into the container using the
[ssh remote extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh).

The container was originally built using
[dev-box.dockerfile](./dev-box.dockerfile).

Key packages to install on it are:

- openssh-server - `ssh` seems the best way to contain Visual Studio Code to the
  container.
- xorg-x11-xauth - This is required to do X11 forwarding, such that I can run
  graphical applications in the container and display them on my screen. This
  works even though I use Gnome-shell Wayland.

Key steps of the dockerfile are:

- `RUN ssh-keygen -A` - the SSH server must have a key generated for it.
- `CMD /usr/sbin/sshd -D -p 3022 -e` - the default command of the container must
  be the SSH server such that I can connect to it. The flags avoid it
  daemonizing, run it on a non-privileged port and have it log to stderr.

[laptop_setup.sh](./laptop_setup.sh) shows how I integrate the container with my
laptop. Podman and docker should be interchangeable.

```bash
# make a dev container
mkdir -p ~/Projects
image_id="$(podman image build -f dev-box.dockerfile . | tee >(cat 1>&2) | tail -n1 | awk '{print $NF}')"
podman container create --name dev-container -v ~/Projects:/root/projects:Z -v ~/.ssh/id_rsa.pub:/root/.ssh/authorized_keys:Z -p 127.0.0.1:3022:3022 "$image_id"

cat > ~/.ssh/config << CONFIG
Host dev-container
  HostName localhost
  User root
  Port 3022
CONFIG
chmod 600 ~/.ssh/config

echo 'podman container start dev-container && ssh -Y dev-container "$@"' > ~/.local/bin/dev-container
chmod +x ~/.local/bin/dev-container

# Manually connect to the dev-container after installing the ssh extension
code --install-extension ms-vscode-remote.remote-ssh
```

I use the `~/Projects` directory as a shared volume between my laptop and the
container.

I build the image without tagging it. Using the `-q` option would achieve the
same thing, but would not show build progress.

I create the container. It is persistent across laptop restarts. I mount my ssh
public key as an authorized key. I port forward 3022 to the ssh daemon. The port
is bound to localhost so isn't available to other users on my WiFi network.

I set up an ssh config file for the container. This is important as it is how
Visual Studio Code's ssh extension lists available targets.

I add a command line program called `dev-container` that starts and connects to
the container. This can be run multiple times. Any arguments will be passed to
the container.

Finally, I add the Visual Studio Code ssh extension.

Everything in the container runs as container `root`. This container `root` does
not run with the root privileges of my laptop. It is a disposable environment
and a large amount of tools in the container are corruptably by the default
user, so there isn't a good reason to run as a less privileged user.

## Review

This setup is working well for me. It is very nearly as smooth as running
everything locally. I need to remember to start the container before I can use
it with Visual Studio Code.

I don't think this makes me unhackable, but it does raise the bar. I think the
main risk is from a vulnerability in Podman that allows a container escape,
combined with a malicious package that tries to escape the container.
