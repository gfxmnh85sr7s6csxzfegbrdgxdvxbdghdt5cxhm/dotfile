# Inspired by yyx990803/dotfiles

author="viko16"
email="16viko@gmail.com"

# Before running this script:
# sudo chown -R ${whoami} /usr/local

# make in case they aren't already there
mkdir -p "/usr/local/lib"
mkdir -p "/usr/local/bin"

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
echo "Updating brew..."
brew update

# Install and use latest zsh
echo "Installing zsh and oh-my-zsh..."
brew install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

source ~/.zshrc
chsh -s /usr/local/bin/zsh

echo "Setting git..."
# Install git
brew install git
# Some git defaults
git config --global color.ui true
git config --global push.default simple
git config --global user.name $author
git config --global user.email $email

# Install nvm
echo "Installing nvm..."
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.zshrc

nvm install stable
nvm alias default stable

# Centralize global npm packages for different node versions
# Note: not compatible with nvm
# npm config set prefix /usr/local/

# Set npm init defaults
echo "Setting npm init defaults..."
npm config set init.author.name $author
npm config set init.author.email $email
npm config set init.version 0.1.0
npm config set init.license MIT

# Install Node modules
modules=(
  eslint
  local-web-server
  pm2
  standard
  typescript
  webpack
  weex-toolkit
  yo
)

echo "Installing global node modules..."
npm install -g ${modules[@]}

# Install Apps from Brew
echo "Intstalling apps from Brew..."

formulae=(
  git-extras
  aria2
  jq
  htop
  tldr
  tree
  you-get
)

brew install ${formulae[@]}

# Install Brew Cask
echo "Installing brew cask..."
brew tap caskroom/cask

# Apps
apps=(
  google-chrome
  firefox
  iterm2
  sublime-text
  visual-studio-code
  sourcetree
  android-platform-tools
  mounty
  qlmarkdown
  qlimagesize
  webpquicklook
  shiftit
  typora
  xmind
  kaleidoscope
  the-unarchiver
  youdao
  neteasemusic
  qq
  dingtalk
  telegram-desktop
  shadowsocksx
  launchbar
  charles
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps from BrewCask..."
brew cask install --appdir="/Applications" ${apps[@]}

# Clone this repo
# git clone https://github.com/yyx990803/dotfiles ~/.dotfiles

# Make some commonly used folders
mkdir ~/Personal
mkdir ~/Work


echo "最后检查 ~"
ls -a ~

echo "最后检查 node"
node -v
npm -v

echo "最后检查 npm"
npm ls -g --depth=0

echo "最后检查 brew"
brew list

echo "最后检查 brew cask"
brew cask list
