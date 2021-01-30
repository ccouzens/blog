# Developing in a virtual machine

30/01/2021

This is a follow on from
[Developing in a container](02-developing-in-a-container.md).

Linux containers don't currently seamlessly support nested containers. This was
a problem, because I occassionally want to run containers within my
dev-environment.

For this reason, I have switched to using a virtual machine as my
dev-environment. This [repository](https://github.com/ccouzens/dev-vm) gives
details.

I should be able to use this from other Operating Systems. I briefly tried on my
work MacBook Pro, but the VirtualBox installation was broken (I don't know how
Macs have a reputation of just-working and being polished, because neither has
been my experience).

When I used a container I chose to share my working directories between host and
container. I'm not doing that with the virtual machine as I've had bad
experiences of shared VM file systems being slow. As such, I need an SSH key for
use with `git` inside the VM. This unfortunately means my github access isn't
isolated from my dev-environment.
