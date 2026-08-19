# Add standard bin directories
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:$PATH"

if [ -d "/workspaces/github/bin" ]; then
    export PATH="$PATH:/workspaces/github/bin"
fi

# Switch to zsh only if in an interactive login shell
if [ -t 1 ] && [ -n "$PS1" ] && command -v zsh >/dev/null 2>&1; then
    exec zsh
fi

