brew-cask:
	brew install caskroom/cask/brew-cask

brew-install:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew-boot2docker:
	brew install boot2docker

brew-virtualbox:
	brew cask install virtualbox

hard-up:
	boot2docker init; boot2docker up; $(boot2docker shellint)

up:
	boot2docker up; $(boot2docker initshell)

shellinit:
	boot2docker shellinit 1>tmp; . ./tmp; rm ./tmp

install: brew-install brew-cask brew-virtualbox brew-boot2docker brew-virtualbox hard-up

