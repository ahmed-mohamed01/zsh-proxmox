#!/bin/bash

# Variables
GITEA_REPO_URL="ssh://git@192.168.8.169:44/abcdw654/zsh-proxmox.git"
LOCAL_REPO_DIR="$HOME/zsh-proxmox"
BIN_DIR="$HOME/.config/zsh-bin"
ZSHRC_DEST="$HOME/.zshrc"
P10K_DEST="$HOME/.p10k.zsh"

# Ensure necessary directories exist
mkdir -p "$BIN_DIR"

# Clone or update the repository
if [ -d "$LOCAL_REPO_DIR/.git" ]; then
  echo "Pulling latest changes from the repository..."
  git -C "$LOCAL_REPO_DIR" pull
else
  echo "Cloning repository..."
  git clone "$GITEA_REPO_URL" "$LOCAL_REPO_DIR"
fi

# Copy binaries to ~/.config/zsh-bin
echo "Copying binaries to $BIN_DIR..."
find "$LOCAL_REPO_DIR" -type f -name "*" -executable -exec cp {} "$BIN_DIR" \;

# Copy .zshrc and .p10k.zsh
echo "Copying .zshrc to $ZSHRC_DEST..."
cp "$LOCAL_REPO_DIR/.zshrc" "$ZSHRC_DEST"

echo "Copying .p10k.zsh to $P10K_DEST..."
cp "$LOCAL_REPO_DIR/.p10k.zsh" "$P10K_DEST"

# Set permissions
echo "Setting permissions for binaries..."
chmod +x "$BIN_DIR"/*

echo "All done!"
echo "Ensure your PATH includes $BIN_DIR by adding the following to your .zshrc if not already present:"
echo 'export PATH="$HOME/.config/zsh-bin:$PATH"'
