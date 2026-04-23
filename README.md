# Codespaces Dotfiles Template

Jose's dotfiles — a starting point for using custom dotfiles (terminal / editor configuration) with GitHub Codespaces

## How to use this repo

In order to use this template, 

1. [create a new repo from this template](https://github.com/cwndrws/codespaces-dotfiles-template/generate). Make it public and name it `dotfiles`.
1. Edit the files that you want to customize in `tmux.conf`, `vimrc`, etc.
1. Push your changes to your `dotfiles` repo
1. Create a new codespace, and see your new dotfiles
1. 🍾

## What's in here?

Just some blank configuration files for popular Text User Interface (TUI) apps that folks may want to use for development in codespaces and a script to put them in the right place.

This supports the following tools:

* Tmux
* Screen
* Vim
* Emacs

## Vim Plugins

This repo uses the wonderful [Vim Plug](https://github.com/junegunn/vim-plug) tool to manage vim plugins. If you'd like to add plugins, simply add them between the opening and closing plug statements in the `vimrc` file.

## 😂 Jokes (as reviewed by three independent comedy agents)

> Jose's dotfiles tell the story of a developer in perpetual pursuit of the perfect colorscheme — his `vimrc` is essentially a graveyard of commented-out themes: gruvbox, darcula, molokai, nord, iceberg, xcode, github, envy, paper, and vividchalk (the lone survivor, for now). The real plot twist? He also has an `emacs` config. He configured `vim-tmux-navigator` so that `C-h/j/k/l` works seamlessly across vim splits *and* tmux panes, achieving true keyboard nirvana — only to be living inside GitHub Codespaces, a browser tab. And if tmux ever lets him down, he's still got `screenrc` in the repo like a 2003 emergency exit. The prefix key is `C-a`, naturally — because `C-b` is for people who didn't grow up on GNU Screen. All of this runs inside Ghostty, the terminal so new it doesn't have an icon yet, navigating an environment so precisely configured that the only thing Jose can't control is which colorscheme he'll wake up with tomorrow.

> Jose has written more lines configuring his text editor than he has written in any single project. His `vimrc` is a graveyard of colorschemes — gruvbox, darcula, nord, molokai, paper — each one lovingly installed, agonized over for three days, commented out, and left to haunt future-Jose like the ghosts of terminals past. His `install.sh` opens by nuking `~/.config` with `rm -rf` before saying hello, because why ask permission when you can ask forgiveness? And his `zshrc`? It's 95% commented-out options from a template, carefully preserved for the day he finally decides whether he wants hyphen-insensitive completion. That day has not come. The dotfiles are version-controlled. The actual projects are not.

> GitHub Codespaces promises you a fully configured, ready-to-code cloud environment — so naturally, the first thing Jose did was spend an entire weekend writing a script to reconfigure it from scratch. It's the developer equivalent of moving into a furnished apartment and immediately replacing all the furniture with the exact same furniture, but *your* furniture. The cloud giveth a pristine machine, and the dotfiles taketh it right back to "looks like my laptop from 2019." Somewhere, a DevOps engineer is weeping into their YAML.
