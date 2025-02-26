#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Install it with: sudo apt install fzf"
    exit 1
fi

# Prompt user for IP address
read -p "Enter the server IP address: " SSH_IP

# Ensure IP is not empty
if [[ -z "$SSH_IP" ]]; then
    echo "No IP entered. Exiting."
    exit 1
fi

# Prompt user for username
read -p "Enter the username: " SSH_USER

# Ensure username is not empty
if [[ -z "$SSH_USER" ]]; then
    echo "No username entered. Exiting."
    exit 1
fi

# Define available SSH keys
SSH_KEYS=(
    "$HOME/.ssh/id_rsa.pub"
    "$HOME/.ssh/local.pub"
    "Enter manually"
)

# Select an SSH key using fzf
KEY_SELECTION=$(printf "%s\n" "${SSH_KEYS[@]}" | fzf --prompt="Select an SSH key: " --height=10 --border)

# If user chooses "Enter manually", prompt for key path
if [[ "$KEY_SELECTION" == "Enter manually" ]]; then
    read -p "Enter the full path to your SSH key: " KEY_SELECTION
fi

# Expand `~` manually in case it appears
KEY_SELECTION=${KEY_SELECTION/#\~/$HOME}

# Ensure the key exists before proceeding
if [ ! -f "$KEY_SELECTION" ]; then
    echo "Invalid key path: $KEY_SELECTION"
    exit 1
fi

# Copy the SSH key to the remote server
echo "Copying SSH key to $SSH_USER@$SSH_IP..."
ssh-copy-id -i "$KEY_SELECTION" "$SSH_USER@$SSH_IP"

echo "✅ SSH key successfully added to $SSH_USER@$SSH_IP"
