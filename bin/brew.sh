# Install Homebrew

# Abort on error
set -e

echo "Checking if Homebrew is already installed..."

# Checks if Homebrew is installed
if test ! $(which brew); then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  (
    echo
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"'
  ) >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed..."
fi

echo "Installing packages..."
apps=(
  awscli
  cowsay
  diff-so-fancy
  docker
  docker-compose
  fd
  fzf
  git
  gnupg
#  koekeishiya/formulae/skhd
  lazygit
  neovim
  node@20
  pinentry-mac
  postgresql@14
  ripgrep
  starship
  television
  tmux
#  yabai
  yarn
  ykman
  zsh
  zsh-syntax-highlighting
)

installed_apps=$(brew list)

for app in ${apps[@]}; do
  (echo "${installed_apps[@]}" | fgrep -q "$app") && echo "$app is already installed" || brew install "${app}"
done

# Make it possible to install fonts
brew tap homebrew/bundle
brew tap isen-ng/dotnet-sdk-versions
brew tap jmhobbs/parrot

casks=(
  dotnet-sdk8
  dotnet-sdk8-0-400
  font-fira-code-nerd-font
  iterm2
  openvpn-connect
  windows-app
)

echo "Installing casks..."
installed_casks=$(brew list --cask)

for cask in ${casks[@]}; do
  (echo "${installed_casks[@]}" | fgrep -q "$cask") && echo "$cask is already installed" || brew install --cask "${cask}"
done

# Update and Upgrade
echo "Updating and upgrading Homebrew..."
yes | brew update
yes | brew upgrade

# Remove outdated versions from the cellar
brew cleanup
