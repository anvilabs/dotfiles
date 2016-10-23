#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Xcode command line tools

if xcode-select --install 2> /dev/null; then
  read -r -p "Press [Enter] key when Xcode command line tools are installed..."
fi

# Install Homebrew if we don't have it
if ! hash brew 2>/dev/null; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  # Make sure we’re using the latest Homebrew
  brew update
fi

# Install zsh
brew install zsh
sudo chsh -s "$(which zsh)"

# Install rcm
brew install thoughtbot/formulae/rcm

# Clone dotfiles from Github
git clone --recursive https://github.com/anvilabs/dotfiles.git ~/.dotfiles/anvilabs

# Synchronize symlinks
rcup -v -d ~/.dotfiles/anvilabs/symlinks

# Copy fonts
rsync -av --no-perms ~/.dotfiles/anvilabs/resources/fonts/ ~/Library/Fonts

read -r -p "? Configure your python environment (with pyenv)? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Configure python environment
  brew install pyenv
  pyenv install 3.5.2
  pyenv global 3.5.2
  pyenv rehash
fi

read -r -p "? Configure your ruby environment (with rbenv)? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Configure ruby environment
  brew install rbenv ruby-build
  rbenv install 2.3.1
  rbenv global 2.3.1
  rbenv rehash
fi

read -r -p "? Configure your node environment (with n)? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Configure node environment
  curl -fsSL http://git.io/n-install | sh
  n latest
fi

# Configure powerline-shell
ln -s ~/.dotfiles/anvilabs/powerline-config.py ~/.dotfiles/anvilabs/powerline-shell/config.py
(cd ~/.dotfiles/anvilabs/powerline-shell && python install.py)

# Configure vim
brew install vim
mkdir ~/.vim/autoload
ln -s ~/.dotfiles/anvilabs/vim-plug/plug.vim ~/.vim/autoload/plug.vim

# Install tmux
brew install tmux

# Install system utilities
brew install the_silver_searcher
brew install trash

# Remove outdated versions from the cellar
brew cleanup

read -r -p "? Create a cron job to update all your globally installed packages? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Add a cron job to update installed packages
  cat > ~/Library/LaunchAgents/co.anvilabs.update.plist <<EOF
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>co.anvilabs.update</string>
      <key>ProgramArguments</key>
      <array>
        <string>sh</string>
        <string>-c</string>
        <string>yes n | $HOME/.dotfiles/anvilabs/update.sh</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
      <key>StartCalendarInterval</key>
      <dict>
        <key>Hour</key>
        <integer>12</integer>
        <key>Minute</key>
        <integer>10</integer>
      </dict>
      <key>StandardErrorPath</key>
      <string>$HOME/Library/Logs/update.sh.log</string>
      <key>StandardOutPath</key>
      <string>$HOME/Library/Logs/update.sh.log</string>
    </dict>
  </plist>
EOF
  launchctl load ~/Library/LaunchAgents/co.anvilabs.update.plist
  echo "Added a cron job at ~/Library/LaunchAgents/co.anvilabs.update.plist"
fi

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript <<EOD
tell application "Terminal"
  local allOpenedWindows
  local initialOpenedWindows
  local windowID
  set themeName to "spacegray"
  (* Store the IDs of all the open terminal windows. *)
  set initialOpenedWindows to id of every window
  (* Open the custom theme so that it gets added to the list
     of available terminal themes (note: this will open two
     additional terminal windows). *)
  do shell script "open '$(pwd)/resources/" & themeName & ".terminal'"
  (* Wait a little bit to ensure that the custom theme is added. *)
  delay 1
  (* Set the custom theme as the default terminal theme. *)
  set default settings to settings set themeName
  (* Get the IDs of all the currently opened terminal windows. *)
  set allOpenedWindows to id of every window
  repeat with windowID in allOpenedWindows
    (* Close the additional windows that were opened in order
       to add the custom theme to the list of terminal themes. *)
    if initialOpenedWindows does not contain windowID then
      close (every window whose id is windowID)
    (* Change the theme for the initial opened terminal windows
       to remove the need to close them in order for the custom
       theme to be applied. *)
    else
      set current settings of tabs of (every window whose id is windowID) to settings set themeName
    end if
  end repeat
end tell
EOD

echo "Done!"
