# -----------------------------------------------------------------------------
# Zsh Configuration (Optimized)
# -----------------------------------------------------------------------------

# PATH Configuration (deduplicated)
typeset -U path PATH
path=(
    $HOME/.local/bin
    $HOME/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    $path
)
export PATH

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

export CLICOLOR=1

# Default Editor
if command -v nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
    export VISUAL="nvim"
elif command -v vim >/dev/null 2>&1; then
    export EDITOR="vim"
    export VISUAL="vim"
fi

# Performance: Disable background auto-update checks on terminal launch
DISABLE_AUTO_UPDATE="true"

# Performance: Faster paste handling
DISABLE_MAGIC_FUNCTIONS=true

# Performance: Speed up git prompts by skipping untracked file scans on huge repos
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Theme
ZSH_THEME="refined"

# Plugins
plugins=(git)

# Load Oh-My-Zsh safely
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
    source $ZSH/oh-my-zsh.sh
fi

# Terminal compatibility: Fallback if host lacks xterm-ghostty terminfo
if [[ "$TERM" == "xterm-ghostty" ]] && ! infocmp "$TERM" >/dev/null 2>&1; then
    export TERM="xterm-256color"
fi

# Aliases
alias ll="ls -lh"
alias la="ls -lah"
alias g="git"
alias ssh="TERM=xterm-256color ssh"
alias cli="jetski --dangerously-skip-permissions"
alias ctop="ssh josebalius.c.googlers.com"


if command -v nvim >/dev/null 2>&1; then
    alias v="nvim"
    alias vim="nvim"
fi

# Load local overrides & secrets (not tracked in Git)
if [ -f "$HOME/.zshrc.local" ]; then
    source "$HOME/.zshrc.local"
fi
