#!/bin/bash
echo "[+] STARTED"

# Variables
LOCAL_NETWORK=$(ip -o -f inet addr show | awk '/scope link/ {print $4}' | head -n 1)
SSH_PORT="22"
NEW_SSH_PORT="2222"

# Path to the ssh config file
SSH_CONFIG="/etc/ssh/sshd_config"

# Func to config ssh eg: x11Forwarding, port, listen
config_ssh()
{
    # Backup current ssh config
    if [! -f "$SSH_CONFIG.BAK" ]; then
        echo "[...] Backing up the current ssh config"
        sudo cp "$SSH_CONFIG" "$SSH_CONFIG.bak"
        echo "[+] BACKUP FILE CREATION COMPELETED"
    else
        echo "[-] BACKUP FILE ALREADY EXISTS. SKIPING THE PROCESS"
    fi

    # Ensure ListenAddress is set to 0.0.0.0 (to listen every conn)
    if grep -q "^#ListenAddress 0.0.0.0" "$SSH_CONFIG"; then
        sudo sed -i 's/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/' "$SSH_CONFIG"
    elif ! grep -q "^ListenAddress 0.0.0.0" "$SSH_CONFIG"; then
        echo "ListenAddress 0.0.0.0" | sudo tee -a "$SSH_CONFIG"
    fi

    # Changing the deafult port with new one
    if grep -q "^#Port $SSH_PORT" "$SSH_CONFIG"; then
        sudo sed -i 's/^#Port $SSH_PORT/Port $NEW_SSH_PORT/' "$SSH_CONFIG"
    elif ! grep -q "^Port $NEW_SSH_PORT" "$SSH_CONFIG"; then
        echo "Port $NEW_SSH_PORT" | sudo tee -a "$SSH_CONFIG"
    fi

    # Enableing X11Forwarding in ssh config
    if grep -q "^#X11Forwarding yes"; then
        sudo sed -i 's/^#X11Forwarding yes/X11Forwading yes/' "$SSH_CONFIG"
    elif ! grep -q "^X11Forwarding yes"; then
        echo "X11Forwarding yes" | sudo tee -a "$SSH_CONFIG"

    fi

}

ufw_install_check(){
    if ! command -v ufw &> /dev/null; then
        echo "[X] Ufw not found"
        echo "[....] Installing UFW"
        sudo apt-get update
        sudo apt-get install -y ufw
    fi
}

config_firewall()
{
    ufw_install_check
    if [ -z "$LOCAL_NETWORK"]; then
        echo "[X] NO LOCAL NETWORK RANGE FOUND"
        return 1
    fi
    NETWORK_ADDRESS=$(echo $LOCAL_NETWORK | cut -d '/' -f1)
    CDIR=$(echo $LOCAL_NETWORK | cur -d '/' -f2)

    NETWORK_RANGE="$NETWORK_ADDRESS/$CDIR"

    echo "[+] Local network range detected: $NETWORK_RANGE"

    # Allow SSH from the local network
    sudo ufw allow from "$NETWORK_RANGE" to any port "$NEW_SSH_PORT"

    # Deny SSH from all other Ip address
    sudo ufw deny "$NEW_SSH_PORT" 

    # Enable ufw if not
    if ! sudo ufw status | grep -q "Status: active"; then
        sudo ufw enable
    fi
    echo "[+] FIREWALL RULES UPDATED"   
}
