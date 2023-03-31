#!/usr/bin/env bash
#color codes
RED='\033[1;31m'
YELLOW='\033[1;33m'
BLUE="\\033[38;5;27m"
SEA="\\033[38;5;49m"
GREEN='\033[1;32m'
CYAN='\033[1;36m'
NC='\033[0m'

#emoji codes
CHECK_MARK="${GREEN}\xE2\x9C\x94${NC}"
X_MARK="${RED}\xE2\x9C\x96${NC}"
PIN="${RED}\xF0\x9F\x93\x8C${NC}"
CLOCK="${GREEN}\xE2\x8C\x9B${NC}"
ARROW="${SEA}\xE2\x96\xB6${NC}"
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
HOT="${ORANGE}\xF0\x9F\x94\xA5${NC}"
WARNING="${RED}\xF0\x9F\x9A\xA8${NC}"
RIGHT_ANGLE="${GREEN}\xE2\x88\x9F${NC}"

# Install Ansible
if dpkg -s ansible >/dev/null 2>&1; then
    echo -e "${WARNING} ${RED}Ansible is not installed. ${WARNING}${NC}"
    echo -e "${YELLOW}Please do the needful and re-run this script."
    exit 1
fi

# Check if python3 and pip is installed
if ! dpkg -s python3 >/dev/null 2>&1; then
    echo -e "${ARROW} ${CYAN}Installing Python3...${NC}"
    sudo apt-get install -y python3 2>&1 > /dev/null
    echo -e "${ARROW} ${GREEN}Python3 installed!${NC}"
fi
if ! dpkg -s python3-pip >/dev/null 2>&1; then
    echo -e "${ARROW} ${CYAN}Installing Python3 Pip...${NC}"
    sudo apt-get install -y python3-pip 2>&1 > /dev/null
    echo -e "${ARROW} ${GREEN}Python3 Pip installed!${NC}"
fi
# Check if pip module watchdog is installed
if ! pip3 list | grep watchdog >/dev/null 2>&1; then
    echo -e "${ARROW} ${CYAN}Installing Python3 Watchdog...${NC}"
    pip3 install watchdog 2>&1 > /dev/null
    echo -e "${ARROW} ${GREEN}Python3 Watchdog installed!${NC}"
fi
