# Anvilabs dotfiles

![](https://img.shields.io/badge/platform-osx-lightgrey.svg)

<img alt="Figlet logo" src=".github/figlet-logo.png" width=542">

This repository holds our opinionated [configuration files](https://en.wikipedia.org/wiki/Configuration_file).

## Installation

Review [the script](https://raw.githubusercontent.com/anvilabs/dotfiles/master/install.sh) and run the following command:
```bash
curl -fsSL https://raw.githubusercontent.com/anvilabs/dotfiles/master/install.sh | sh
```

> You can also [fork this repo](https://github.com/anvilabs/dotfiles#fork-destination-box) and [keep it updated](http://robots.thoughtbot.com/keeping-a-github-fork-updated) in case you want to make customizations.

---

You can also try these dotfiles without polluting your development environment.

First install [Vagrant](https://www.vagrantup.com/docs/installation/) and [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Then set up a Sierra machine by running:

```bash
vagrant init jhcook/macos-sierra
vagrant up --provider virtualbox
```

## What the installation script sets up:

Unix:
- [zsh](http://www.zsh.org/) as your default shell
- [zplug](https://github.com/zplug/zplug) for managing zsh plugins
- [vim-plug](https://github.com/junegunn/vim-plug) for managing vim plugins
- [Powerline](https://github.com/banga/powerline-shell) for your shell prompt
- [A cron job](https://raw.githubusercontent.com/anvilabs/dotfiles/master/update.sh) to regularly update your global packages
- [trash](http://hasseg.org/trash/) as a replacement for the `rm` command

Programming language environments (if you want them):

- [pyenv](https://github.com/yyuu/pyenv) for Python
- [rbenv](https://github.com/rbenv/rbenv) for Ruby
- [n](https://github.com/tj/n) for Node.js

Bundled zsh plugins:
- [fzf](https://github.com/junegunn/fzf) fuzzy finder
- [z](https://github.com/rupa/z) integrated with [fzf](https://github.com/junegunn/fzf). Run the `z` command to see the list of your most used directories
- [k](https://github.com/supercrabtree/k) as a replacement for `ls`
- [History substring search](https://github.com/zsh-users/zsh-history-substring-search) with UP and DOWN arrows
- [Additional completion definitions](https://github.com/zsh-users/zsh-completions)
- [Syntax highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Useful macOs utilities](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/osx)

Bundled Vim plugins:
- [Syntax checking](https://github.com/scrooloose/syntastic)
- [Git diff in the "gutter"](https://github.com/airblade/vim-gitgutter)
- [Go to Terminal or File manager](https://github.com/justinmk/vim-gtfo)
- [Better Javascript syntax support](https://github.com/pangloss/vim-javascript)
- [Commenting out](https://github.com/tomtom/tcomment_vim)
- [Git wrapper](https://github.com/tpope/vim-fugitive)
- [Enable repeating supported plugin maps](https://github.com/tpope/vim-repeat)
- [Quoting/parenthesizing](https://github.com/tpope/vim-surround)
- [Code completion](https://github.com/Valloric/YouCompleteMe)
- [fzf commands](https://github.com/junegunn/fzf.vim)

This repo also includes the Spacegray color theme both for [Terminal.app](https://github.com/wtanna/Spacegray-OSX-Terminal-Theme) and for [iTerm2](https://github.com/christianbundy/spacegrey-iterm). It will set up the theme automatically with the [Monoid font](https://larsenwork.com/monoid/) for Terminal.app.

## Make your own customizations

Put your customizations either in `~/.dotfiles-local/symlinks/` or at the root appended with `.local`. Customizable symlinks include:

- `gitconfig.local`
- `tmux.conf.local`
- `vimrc.local`
- `vimrc.bundles.local`
- `zshenv.local`
- `zshrc.local`
- `zshrc.plugins.local`

For example, your `gitconfig.local` might look like the following:

```ini
[user]
  name = Ayan Yenbekbays
  email = ayan.yenb@gmail.com
  github = yenbekbay
  signingkey = ayan.yenb@gmail.com
[commit]
  gpgsign = true
[gpg]
  program = /usr/local/bin/gpg2
```

If you added your local dotfiles in `~/.dotfiles-local/symlinks`, run `syncdotfiles` to apply your changes.

## Credits

Inspired by:

- [@b4b4r07's dotfiles](https://github.com/b4b4r07/dotfiles)
- [@mathiasbynens's dotfiles](https://github.com/mathiasbynens/dotfiles)
- [@thoughtbot's dotfiles](https://github.com/thoughtbot/dotfiles)

## License

[MIT License](./LICENSE) © Anvilabs LLC
