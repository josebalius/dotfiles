#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="$HOME/dotfiles_install.log"

exec > >(tee -i "$LOG_FILE")
exec 2>&1
set -x

OS="$(uname -s)"
ARCH="$(uname -m)"

# ----------------------------------------------------
# 1. OS-specific packages & Neovim installation
# ----------------------------------------------------
if [ "$OS" = "Linux" ]; then
    PACKAGES_NEEDED="\
        silversearcher-ag \
        bat \
        fuse \
        dialog \
        apt-utils \
        libfuse2"

    if command -v dpkg >/dev/null 2>&1; then
        if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
            if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
                sudo apt-get update
            fi
            sudo echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections 2>/dev/null || true
            sudo apt-get -y -q install ${PACKAGES_NEEDED} 2>/dev/null || true
        fi
    fi

    # Install Neovim for Linux if not present or needs update
    if ! command -v nvim >/dev/null 2>&1 || ! nvim --version >/dev/null 2>&1; then
        if command -v modprobe >/dev/null 2>&1; then
            sudo modprobe fuse 2>/dev/null || true
        fi
        if command -v groupadd >/dev/null 2>&1; then
            sudo groupadd fuse 2>/dev/null || true
            sudo usermod -a -G fuse "$(whoami)" 2>/dev/null || true
        fi
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
        chmod u+x nvim-linux-x86_64.appimage
        if [ -w /usr/local/bin ]; then
            mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
        else
            sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim 2>/dev/null || {
                mkdir -p "$HOME/.local/bin"
                mv nvim-linux-x86_64.appimage "$HOME/.local/bin/nvim"
            }
        fi
    fi

    # Install Zellij for Linux if not present
    if ! command -v zellij >/dev/null 2>&1; then
        ZELLIJ_ARCH="x86_64"
        if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
            ZELLIJ_ARCH="aarch64"
        fi
        TMP_DIR="/tmp/zellij-install-$$"
        mkdir -p "$TMP_DIR"
        if curl -sL "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ZELLIJ_ARCH}-unknown-linux-musl.tar.gz" | tar -xz -C "$TMP_DIR"; then
            if [ -w /usr/local/bin ]; then
                mv "$TMP_DIR/zellij" /usr/local/bin/zellij
            else
                mkdir -p "$HOME/.local/bin"
                mv "$TMP_DIR/zellij" "$HOME/.local/bin/zellij"
            fi
            chmod +x "$HOME/.local/bin/zellij" 2>/dev/null || true
        fi
        rm -rf "$TMP_DIR"
    fi

elif [ "$OS" = "Darwin" ]; then
    # macOS setup
    if ! command -v nvim >/dev/null 2>&1 || ! nvim --version >/dev/null 2>&1; then
        NVIM_ARCH="arm64"
        if [ "$ARCH" = "x86_64" ]; then
            NVIM_ARCH="x86_64"
        fi
        TMP_DIR="/tmp/nvim-install-$$"
        mkdir -p "$TMP_DIR"
        curl -sL "https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-${NVIM_ARCH}.tar.gz" | tar -xz -C "$TMP_DIR"
        mkdir -p "$HOME/.local"
        rm -rf "$HOME/.local/nvim"
        cp -r "$TMP_DIR/nvim-macos-${NVIM_ARCH}" "$HOME/.local/nvim"
        rm -rf "$TMP_DIR"

        # Clear quarantine and sign with JIT entitlements if needed
        xattr -dr com.apple.quarantine "$HOME/.local/nvim" 2>/dev/null || true
        if command -v codesign >/dev/null 2>&1; then
            ENT_FILE="/tmp/nvim-entitlements-$$.plist"
            cat << 'EOF' > "$ENT_FILE"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.cs.allow-jit</key>
    <true/>
    <key>com.apple.security.cs.allow-unsigned-executable-memory</key>
    <true/>
    <key>com.apple.security.cs.disable-executable-page-protection</key>
    <true/>
</dict>
</plist>
EOF
            codesign -s - --force --options runtime --entitlements "$ENT_FILE" "$HOME/.local/nvim/bin/nvim" 2>/dev/null || true
            rm -f "$ENT_FILE"
        fi

        # Wrapper in /usr/local/bin or ~/.local/bin
        if [ -w /usr/local/bin ] || [ -w /usr/local/bin/nvim ]; then
            cat << 'EOF' > /usr/local/bin/nvim
#!/bin/sh
exec "$HOME/.local/nvim/bin/nvim" "$@"
EOF
            chmod +x /usr/local/bin/nvim
        else
            mkdir -p "$HOME/.local/bin"
            cat << 'EOF' > "$HOME/.local/bin/nvim"
#!/bin/sh
exec "$HOME/.local/nvim/bin/nvim" "$@"
EOF
            chmod +x "$HOME/.local/bin/nvim"
        fi
    fi

    # Install Zellij for macOS if not present
    if ! command -v zellij >/dev/null 2>&1; then
        ZELLIJ_ARCH="aarch64"
        if [ "$ARCH" = "x86_64" ]; then
            ZELLIJ_ARCH="x86_64"
        fi
        TMP_DIR="/tmp/zellij-install-$$"
        mkdir -p "$TMP_DIR"
        if curl -sL "https://github.com/zellij-org/zellij/releases/latest/download/zellij-${ZELLIJ_ARCH}-apple-darwin.tar.gz" | tar -xz -C "$TMP_DIR"; then
            mkdir -p "$HOME/.local/bin"
            cp "$TMP_DIR/zellij" "$HOME/.local/bin/zellij"
            chmod +x "$HOME/.local/bin/zellij"
            xattr -dr com.apple.quarantine "$HOME/.local/bin/zellij" 2>/dev/null || true
        fi
        rm -rf "$TMP_DIR"
    fi
fi

# ----------------------------------------------------
# 2. Symlink configuration files
# ----------------------------------------------------
mkdir -p "$HOME/.config"

ln -sfn "$DOTFILES_DIR/tmux.conf" "$HOME/.tmux.conf"
ln -sfn "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
ln -sfn "$DOTFILES_DIR/vim" "$HOME/.vim"
ln -sfn "$DOTFILES_DIR/emacs" "$HOME/.emacs"
ln -sfn "$DOTFILES_DIR/screenrc" "$HOME/.screenrc"
ln -sfn "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"
ln -sfn "$DOTFILES_DIR/bash_profile" "$HOME/.bash_profile"
ln -sfn "$DOTFILES_DIR/gitignore_global" "$HOME/.gitignore_global"

if command -v git >/dev/null 2>&1; then
    git config --global core.excludesfile "$HOME/.gitignore_global"
fi

ln -sfn "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
ln -sfn "$DOTFILES_DIR/config/zellij" "$HOME/.config/zellij"
mkdir -p "$HOME/.config/herdr"
ln -sfn "$DOTFILES_DIR/config/herdr/config.toml" "$HOME/.config/herdr/config.toml"

# Ghostty config
mkdir -p "$HOME/.config/ghostty"
ln -sfn "$DOTFILES_DIR/ghostty-config" "$HOME/.config/ghostty/config"
if [ -d "$HOME/Library/Application Support/com.mitchellh.ghostty" ]; then
    ln -sfn "$DOTFILES_DIR/ghostty-config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
fi

# ----------------------------------------------------
# 3. Oh-My-Zsh Installation
# ----------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ] && command -v git >/dev/null 2>&1; then
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# ----------------------------------------------------
# 4. Install Plugins
# ----------------------------------------------------
if command -v vim >/dev/null 2>&1; then
    vim -E -s -u "$HOME/.vimrc" +PlugInstall +qa 2>/dev/null || true
fi

if command -v nvim >/dev/null 2>&1; then
    nvim --headless "+PlugInstall --sync" +qa 2>/dev/null || true
fi

# ----------------------------------------------------
# 4. Default shell
# ----------------------------------------------------
if [ "$SHELL" != "$(which zsh 2>/dev/null)" ] && command -v zsh >/dev/null 2>&1; then
    if [ "$OS" = "Linux" ]; then
        sudo chsh -s "$(which zsh)" "$(whoami)" 2>/dev/null || true
    fi
fi

echo "Dotfiles installation completed successfully!"
