#!/bin/bash

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Intro banner
echo -e "${CYAN}🔧 Setting up IG-HACK v2.5...${RESET}"
sleep 1

# Update packages
echo -e "${GREEN}Updating system packages...${RESET}"
apt-get update -y && apt-get upgrade -y

# Install necessary packages
REQUIRED_PKGS=(python python2 git lolcat)
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v $pkg &>/dev/null; then
        echo -e "${GREEN}Installing $pkg...${RESET}"
        pkg install $pkg -y
    else
        echo -e "${CYAN}$pkg already installed.${RESET}"
    fi
done

# Ensure TOR is installed
if ! command -v tor &>/dev/null; then
    echo -e "${GREEN}Installing Tor...${RESET}"
    pkg install tor -y
else
    echo -e "${CYAN}Tor already installed.${RESET}"
fi

# Clone the repo
if [ ! -d "ighack" ]; then
    echo -e "${GREEN}Cloning the IG-HACK repository...${RESET}"
    git clone https://github.com/dark-player/igbrute
else
    echo -e "${CYAN}Repository already exists!${RESET}"
fi

# Final setup message
echo -e "${GREEN}✔️ Setup complete! Run 'bash ighack.sh' to start.${RESET}"
