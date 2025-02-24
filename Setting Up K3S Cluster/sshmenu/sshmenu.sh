#!/bin/bash 

# Select a server using fzf
SERVER=$(cat ~/.ssh/servers.txt | fzf --prompt="Select a server: " --height=10 --border)

# Exit if no server is selected
if [ -z "$SERVER" ]; then
    echo "No server selected."
    exit 1
fi

# Extract user and host from selection (assuming format: "server_name user@host")
SSH_USER=$(echo "$SERVER" | awk '{print $2}')

# Define available SSH keys
SSH_KEYS=(
    "$HOME/.ssh/id_rsa"
    "$HOME/.ssh/id_ed25519"
    "$HOME/.ssh/custom_key"
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

# Connect using the selected key
echo "Connecting to $SSH_USER with key $KEY_SELECTION..."
ssh -i "$KEY_SELECTION" "$SSH_USER"
