# SSH Nicety

When developing locally, it is convenient to press `ctrl` + `shift` + `t` to
open a second Gnome-Terminal tab in the same directory. And it is handy to be
able to type `code .` to open an instance of VSCode for that folder.

Unfortunately, neither works when using SSH. I use SSH for my dev-vm.

The new terminal tab won't be connected to the remote machine. I'll have to type
`ssh vagrant-dev-vm`, followed by `cd directory/I/want`.

`code` won't be recognized as a command on the remote machine. I'll have to open
VSCode, click the ssh icon, select the destination, and then navigate to the
directory.

I think I can do better.

I'm going to create an app to improve this situation. I'm giving it the name
`ssh-nicety` until someone suggests something better.

I'll run `ssh-nicety-server` on my local laptop. This will listen on a port on
localhost. It will autorun every time I login.

I'll edit my `ssh_config` to always forward this port to `vagrant-dev-vm`.

I'll install `ssh-nicety` on the VM. I'll create a soft-link called `code` and a
soft-link called `term`. When I run `code .` on the VM, it will send a message
to `ssh-nicety-server` telling it to run
`code --folder-uri vscode-remote://ssh-remote+vagrant-dev-vm$PATH`. When I run
`term .`, it will send a message to `ssh-nicety-server` telling it to run
`gnome-terminal --tab -- ssh -t vagrant-dev-vm 'cd $PATH; exec $SHELL -l'`.

## Security Considerations

The point of running a virtual machine is that I can avoid malicious code in it
harming the rest of my laptop. What I am proposing will allow the VM to launch
two apps outside of the VM. This should be handled carefully.

1. Only bind to localhost. This will block other computers on the same WIFI
   network connecting to `ssh-nicety-server`.
2. Do not receive shell instructions in `ssh-nicety-server`. Instead, listen for
   a specific pre-approved list of commands such as
   `{"program": "code", "server": "vagrant-dev-vm", "path": "/home/vagrant/git/github.com/ccouzens/ssh-nicety"}`
   which will then safely perform the correct action on my laptop.
3. I do not think it will be necessary, but `ssh-nicety-server` could prompt
   before opening anything.
4. Possibly the message could include a secret, or proof of knowledge, to show
   it is really me. I suspect it wouldn't be possible to keep a secret on a VM
   that only "good" programs could know about, so I don't think this would add
   much value.
5. On the other hand, if my laptop had other users, then a secret would protect
   me from them launching new terminals and VSCode instances.
6. Variables such as paths and ssh server names should be properly escaped when
   launching `code` and `gnome-terminal`.
