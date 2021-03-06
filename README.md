## Getting Boot2Docker Going on OS X

### Table of Contents
* [Introduction](#introduction)
* [Prerequisites](#prerequisites)
* [Video](#video-walkthrough) 
* [Makefile Code](#checkout-the-code)
* [Quick Install Using Makefile](#quick-install)
* [Step by Step Install](#one-step-at-a-time-install)
* [Testing](#testing)

### Introduction
Interested in getting Docker going on OS X? Wondering how all that magic works? Tired of wandering around in tunnels when things go bad with the install?

This guide will walk you through installing **boot2docker**, **virtualbox**, and **docker** on your Mac/OSX based machine using **brew** and **cask**. 

Alternately, you can just head on over to the [boot2docker site](http://boot2docker.io/) and use their installer if you are feeling lucky.  Please note that this author has had a better overall experience with **boot2docker** by doing the installation through the **brew** and **cask** methods.

![i have no recollection of this place](http://i.imgur.com/itIGzuv.jpg)

***It does not do to leave a live dragon out of your calculations, if you live near him.*** - [J.R.R. Tolkien](http://en.wikipedia.org/wiki/J._R._R._Tolkien)

### Prerequisites

1. You need an OSX based machine.
2. A terminal shell open. To open a term, from Spotlight type 'term' and hit enter.
3. You need to have [Homebrew](http://brew.sh) installed. Instructions [below](#install-brew).
4. You need to have [Cask](http://caskroom.io) installed. Instructions [below](#install-cask).
5. You need to have [VirtualBox](https://www.virtualbox.org/) installed. Instructions [below](#install-virtualbox).

### Video Walkthrough

Here's another great video where I type a bit and then talk a bit. Also, I'm not the only wizard with a hat.

[![](https://raw.githubusercontent.com/kordless/boot2docker-ing/master/assets/video.png)](https://vimeo.com/120645766)

### Checkout the Code

You can checkout the code, if you want to call it that, by doing the following:

    git clone https://github.com/kordless/boot2docker-ing.git

Change into the directory:

	cd boot2docker-ing
	
Admire the **Makefile**:

```
brew-cask:
	brew install caskroom/cask/brew-cask

brew-install:
	curl -s https://raw.githubusercontent.com/Homebrew/install/master/install > tmp; ruby tmp; rm tmp

brew-boot2docker:
	brew install boot2docker

brew-virtualbox:
	brew cask install virtualbox

hard-stop:
	boot2docker delete

hard-up: hard-stop up

up: shellinit
	boot2docker up

shellinit:
	boot2docker shellinit 1>tmp; . ./tmp; rm ./tmp

install: brew-install brew-cask brew-virtualbox brew-boot2docker brew-virtualbox hard-up
```

That's it for the 'code'.

### Quick Install

I'm skeptical this will work first run for you, but you can try it if you are reasonably sure you don't have [**brew**](http://brew.sh/), [**virtualbox**](https://www.virtualbox.org/) or [**docker**](https://docker.com/) installed:

    make install
    
If that fusses at you, we should take it one step at a time.

### One Step at a Time Install

Let's start by installing **brew**, an OS X package manager.

#### Install Brew
Start out by checking if you have **brew** installed:

    superman:boot2docker-ing kord$ brew -v
	Homebrew 0.9.5

If you don't have **brew** installed, Homebrew is best installed by doing:

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
If you do have it installed, go ahead and update it:

    brew update
    
Now we have **brew** installed and updated, we need to install VirtualBox.

#### Install Cask
[Cask](https://github.com/caskroom/homebrew-cask) is a workflow based installer for applications running on OS X. You can install it using **brew**:

	brew install caskroom/cask/brew-cask

Today was the first time I used it, and it's pretty slick.

#### Install VirtualBox

Now you can install VirtualBox with one line:

	brew cask install virtualbox
	
Simple!

#### Boot2Docker
[Boot2Docker](http://boot2docker.io) is what we are here to install, so it's good we are at this step. Let's install it:

    brew install boot2docker

A bit of wizardry later, a beer appears. 🍺

Now let's initialize the VM and start it:

	boot2docker -v init
	boot2docker up
	
If you get errors fussing about a missing port, [see this issue on Github](https://github.com/boot2docker/boot2docker-cli/issues/148) and try the following:

	unset DYLD_LIBRARY_PATH
	unset LD_LIBRARY_PATH
	
..and then rerun things (again, only if init failed):

	boot2docker delete
	boot2docker -v init
	boot2docker up

If **boot2docker up** succeeds, you'll see something along these lines:

	superman:boot2docker-ing kord$ boot2docker up
	Waiting for VM and Docker daemon to start...
	.......................ooooooooooooooooo
	Started.
	Writing /Users/kord/.boot2docker/certs/boot2docker-vm/ca.pem
	Writing /Users/kord/.boot2docker/certs/boot2docker-vm/cert.pem	
	Writing /Users/kord/.boot2docker/certs/boot2docker-vm/key.pem
	Your environment variables are already set correctly.

One last thing you can test is connecting to the instance:

```
superman:boot2docker-ing kord$ boot2docker ssh
                        ##        .
                  ## ## ##       ==
               ## ## ## ##      ===
           /""""""""""""""""\___/ ===
      ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
           \______ o          __/
             \    \        __/
              \____\______/
 _                 _   ____     _            _
| |__   ___   ___ | |_|___ \ __| | ___   ___| | _____ _ __
| '_ \ / _ \ / _ \| __| __) / _` |/ _ \ / __| |/ / _ \ '__|
| |_) | (_) | (_) | |_ / __/ (_| | (_) | (__|   <  __/ |
|_.__/ \___/ \___/ \__|_____\__,_|\___/ \___|_|\_\___|_|
Boot2Docker version 1.5.0, build master : a66bce5 - Tue Feb 10 23:31:27 UTC 2015
Docker version 1.5.0, build a8a31ef
docker@boot2docker:~$
```

Finally, set **boot2docker** to automatically start after rebooting your machine:

	ln -sfv /usr/local/opt/boot2docker/*.plist ~/Library/LaunchAgents

### Testing

#### Check Docker Works
[Docker](https://docker.io/) should have been installed with **boot2docker**, so let's try it out:

	docker version
	
You should get back something like this:

	superman:boot2docker-ing kord$ docker version
	Client version: 1.4.1
	Client API version: 1.16
	Go version (client): go1.3.3
	Git commit (client): 5bc2ff8
	OS/Arch (client): darwin/amd64
	Server version: 1.5.0
	Server API version: 1.17
	Go version (server): go1.4.1
	Git commit (server): a8a31ef

If something goes wrong, it looks like this:

	superman:boot2docker-ing kord$ docker version
	Client version: 1.4.1
	Client API version: 1.16
	Go version (client): go1.3.3
	Git commit (client): 5bc2ff8
	OS/Arch (client): darwin/amd64
	FATA[0000] An error occurred trying to connect: Get https:///var/run/docker.sock/v1.16/version: dial unix /var/run/docker.sock: no such file or directory

You can double check you have the correct environment variables set by doing the following:

	$(boot2docker shellinit)
	
Here's the output:

	superman:boot2docker-ing kord$ $(boot2docker shellinit)
	Writing /Users/kord/.boot2docker/certs/boot2docker-vm/ca.pem
	Writing /Users/kord/.boot2docker/certs/boot2docker-vm/cert.pem
	Writing /Users/kord/.boot2docker/certs/boot2docker-vm/key.pem
	
If **boot2docker** crashes, which happens from time to time:

	superman:boot2docker-ing kord$ $(boot2docker shellinit)
	error in run: VM "boot2docker-vm" is not running.
	
Doing a hard restart will help (again, only do this if something is wrong):

	boot2docker restart
	$(boot2docker shellinit)

### Test Run a Container	
Let's try to use docker:

	docker run hello-world
	
Here's the expected output:

```
superman:boot2docker-ing kord$ docker run hello-world
Unable to find image 'hello-world:latest' locally
511136ea3c5a: Pull complete
31cbccb51277: Pull complete
e45a5af57b00: Pull complete
hello-world:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security.
Status: Downloaded newer image for hello-world:latest
Hello from Docker.
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (Assuming it was not already locally available.)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

For more examples and ideas, visit:
 http://docs.docker.com/userguide/
superman:boot2docker-ing kord$
```

That's about it!  Open an issue if find an error or do a pull request and add some stuff!

Don't forget to signup for [GiantSwarm](https://giantswarm.io)!
