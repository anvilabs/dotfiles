#!/usr/bin/env bash

LOG_FILE=~/Library/Logs/update.sh.log

if [ ! -f $LOG_FILE ]; then
  # Create the log file if it doesn't exist
  touch $LOG_FILE
fi

# shellcheck disable=SC2162
exec 1> >(while read line; do echo "$(date): ${line}" >> $LOG_FILE; done) 2>&1

export PATH="${PATH}:/usr/local/bin:${HOME}/.rbenv/bin"
export HOMEBREW_CASK_OPTS='--appdir=/Applications --caskroom=/opt/homebrew-cask/Caskroom'

echo '----------'

if ping -c 1 gooeewedwedwegle.com >> /dev/null 2>&1; then
  if hash brew 2>/dev/null; then
    echo '** Updating brew'
    brew update

    echo '** Updating brew packages'
    brew upgrade

    echo '** Updating brew cask formulae'
    brew cask update

    echo '** Cleaning up brew cellar'
    brew cleanup
    brew cask cleanup
  fi

  echo '** Updating dotfiles submodules'
  (cd ~/.fzf && git pull)
  (cd ~/.dotfiles && git submodule foreach git pull origin master)

  echo '** Updating gems'
  if hash rbenv 2>/dev/null; then
    eval "$(rbenv init -)"
  fi
  gem update
else
  echo 'No internet connection'
fi
