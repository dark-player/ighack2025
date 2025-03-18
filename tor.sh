#!/bin/bash

# Colors
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Start TOR Service
echo -e "${CYAN}Starting Tor for secure connections...${RESET}"

# Check if Tor is running
if pgrep -x "tor" > /dev/null; then
    echo -e "${GREEN}✔️ Tor is already running.${RESET}"
else
    tor &
    sleep 3
    if pgrep -x "tor" > /dev/null; then
        echo -e "${GREEN}✔️ Tor started successfully!${RESET}"
    else
        echo -e "${RED}❌ Failed to start Tor. Check your installation!${RESET}"
        exit 1
    fi
fi

# Verify IP through Tor
echo -e "${CYAN}Checking your new Tor IP...${RESET}"
TOR_IP=$(curl --silent --socks5 127.0.0.1:9050 https://check.torproject.org | grep -oP '(?<=Your IP address appears to be: )[0-9\.]+')

if [ -n "$TOR_IP" ]; then
    echo -e "${GREEN}✔️ Tor IP confirmed: $TOR_IP${RESET}"
else
    echo -e "${RED}❌ Failed to fetch Tor IP. Check Tor connection!${RESET}"
    exit 1
fi

# Success message
echo -e "${GREEN}🎯 You're now running through Tor!${RESET}"
