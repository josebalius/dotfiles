# Codespaces Dotfiles Template

Hi, I'm jose! 👋

This repo is a starting point for using custom dotfiles (terminal / editor configuration) with GitHub Codespaces

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

## Jokes

> Why did the dotfiles developer get kicked out of the party? Because every time someone asked where their settings were, they said "they're hidden — you just have to know to look for them."

> Jose's dotfiles are technically "hidden" files — which is fitting, because his entire development environment lives inside a Codespace that disappears the moment he closes his laptop.

> Jose's dotfiles repo is like a Switzerland of the editor wars — it hosts both vim and emacs configs, not because it's neutral, but because it's too afraid to lose friends at the hackathon.
