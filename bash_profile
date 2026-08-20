# Add standard bin directories

export PATH="$HOME/.local/bin:$HOME/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:$PATH"

if [ -d "/workspaces/github/bin" ]; then
    export PATH="$PATH:/workspaces/github/bin"
fi

# Terminal compatibility: Fallback if host lacks xterm-ghostty terminfo
if [[ "$TERM" == "xterm-ghostty" ]] && ! infocmp "$TERM" >/dev/null 2>&1; then
    export TERM="xterm-256color"
fi

# Switch to zsh only if in an interactive login shell
if [ -t 1 ] && [ -n "$PS1" ] && command -v zsh >/dev/null 2>&1; then
    exec zsh
fi
