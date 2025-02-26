#!/bin/bash

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo "Error: fzf is not installed. Install it with: sudo apt install fzf"
    exit 1
fi

# Check if the server list file exists
SERVER_LIST="$HOME/.ssh/servers.txt"
if [[ ! -f "$SERVER_LIST" ]]; then
    echo "Error: Server list file not found at $SERVER_LIST"
    exit 1
fi

# Let user select a server using fzf
SERVER=$(cat "$SERVER_LIST" | fzf --prompt="Select a server or press ESC to enter manually: " --height=10 --border)

# If no selection was made, ask for manual input
if [[ -z "$SERVER" ]]; then
    read -p "Enter the hostname or IP manually: " SSH_HOST
else
    # Extract hostname from selection (assuming format: "server_name user@host")
    SSH_HOST=$(echo "$SERVER" | awk '{print $2}' | awk -F '@' '{print $2}')
fi

# Ensure input is not empty
if [[ -z "$SSH_HOST" ]]; then
    echo "No hostname entered. Exiting."
    exit 1
fi

# Remove old SSH key
echo "Removing old SSH key for $SSH_HOST..."
ssh-keygen -R "$SSH_HOST"

# Optional: Show updated known_hosts file
echo "Updated known_hosts:"
sed -n '/'"$SSH_HOST"'/p' ~/.ssh/known_hosts || echo "No remaining entries for $SSH_HOST."

echo "✅ SSH key for $SSH_HOST removed successfully."
