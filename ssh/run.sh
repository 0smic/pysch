#!/bin/bash
echo "[+] STARTED"

# Variables
LOCAL_NETWORK=$(ip -o -f inet addr show | awk '/scope link/ {print $4}' | head -n 1)
SSH_PORT="22"
NEW_SSH_PORT="2222"

# Path to the ssh config file
SSH_CONFIG="/etc/ssh/sshd_config"

# Function to configure SSH
config_ssh()
{
    # Backup current ssh config
    if [ ! -f "$SSH_CONFIG.bak" ]; then
        echo "[...] Backing up the current ssh config"
        sudo cp "$SSH_CONFIG" "$SSH_CONFIG.bak"
        echo "[+] BACKUP FILE CREATION COMPLETED"
    else
        echo "[-] BACKUP FILE ALREADY EXISTS. SKIPPING THE PROCESS"
    fi

    # Ensure ListenAddress is set to 0.0.0.0 (to listen every connection)
    if grep -q "^#ListenAddress 0.0.0.0" "$SSH_CONFIG"; then
        sudo sed -i 's/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' "$SSH_CONFIG"
    elif ! grep -q "^ListenAddress 0.0.0.0" "$SSH_CONFIG"; then
        echo "ListenAddress 0.0.0.0" | sudo tee -a "$SSH_CONFIG"
    fi

    # Changing the default port with the new one
    if grep -q "^#Port $SSH_PORT" "$SSH_CONFIG"; then
        sudo sed -i 's/^#Port 22/Port 2222/' "$SSH_CONFIG"
    elif ! grep -q "^Port 2222" "$SSH_CONFIG"; then
        echo "Port $NEW_SSH_PORT" | sudo tee -a "$SSH_CONFIG"
    fi

    # Enabling X11Forwarding in ssh config
    if grep -q "^#X11Forwarding yes" "$SSH_CONFIG"; then
        sudo sed -i 's/^#X11Forwarding yes/X11Forwarding yes/' "$SSH_CONFIG"
    elif ! grep -q "^X11Forwarding yes" "$SSH_CONFIG"; then
        echo "X11Forwarding yes" | sudo tee -a "$SSH_CONFIG"
    fi
}

# Function to check if UFW is installed
ufw_install_check(){
    if ! command -v ufw &> /dev/null; then
        echo "[X] UFW not found"
        echo "[....] Installing UFW"
        sudo apt-get update
        sudo apt-get install -y ufw
    fi
}

# Function to configure firewall
config_firewall()
{
    ufw_install_check
    if [ -z "$LOCAL_NETWORK" ]; then
        echo "[X] NO LOCAL NETWORK RANGE FOUND"
        return 1
    fi
    NETWORK_ADDRESS=$(echo $LOCAL_NETWORK | cut -d '/' -f1)
    CIDR=$(echo $LOCAL_NETWORK | cut -d '/' -f2)

    NETWORK_RANGE="$NETWORK_ADDRESS/$CIDR"

    echo "[+] Local network range detected: $NETWORK_RANGE"

    # Allow SSH from the local network
    sudo ufw allow from "$NETWORK_RANGE" to any port "$NEW_SSH_PORT"

    # Deny SSH from all other IP addresses
    sudo ufw deny "$NEW_SSH_PORT"

    # Enable UFW if not already enabled
    if ! sudo ufw status | grep -q "Status: active"; then
        sudo ufw enable
    fi
    echo "[+] FIREWALL RULES UPDATED"
}
