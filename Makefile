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

