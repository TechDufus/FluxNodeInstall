#!/bin/bash
#color codes
RED='\033[1;31m'
CYAN='\033[1;36m'
NC='\033[0m'
#emoji codes
BOOK="${RED}\xF0\x9F\x93\x8B${NC}"
WORNING="${RED}\xF0\x9F\x9A\xA8${NC}"
sleep 2
echo -e "${BOOK} ${CYAN}Pre-start process starting...${NC}"
echo -e "${BOOK} ${CYAN}Checking if benchmark or daemon is running${NC}"
bench_status_pind=$(pgrep fluxbenchd)
daemon_status_pind=$(pgrep fluxd)
if [[ "$bench_status_pind" == "" && "$daemon_status_pind" == "" ]]; then
    echo -e "${BOOK} ${CYAN}No running instance detected...${NC}"
else
    if [[ "$bench_status_pind" != "" ]]; then
        echo -e "${WORNING} Running benchmark process detected${NC}"
        echo -e "${WORNING} Killing benchmark...${NC}"
        sudo killall -9 fluxbenchd > /dev/null 2>&1  && sleep 2
    fi
    if [[ "$daemon_status_pind" != "" ]]; then
        echo -e "${WORNING} Running daemon process detected${NC}"
        echo -e "${WORNING} Killing daemon...${NC}"
        sudo killall -9 fluxd > /dev/null 2>&1  && sleep 2
    fi
    sudo fuser -k 16125/tcp > /dev/null 2>&1 && sleep 1
fi
bench_status_pind=$(pgrep zelbenchd)
daemon_status_pind=$(pgrep zelcashd)
if [[ "$bench_status_pind" == "" && "$daemon_status_pind" == "" ]]; then
    echo -e "${BOOK} ${CYAN}No running instance detected...${NC}"
else
    if [[ "$bench_status_pind" != "" ]]; then
        echo -e "${WORNING} Running benchmark process detected${NC}"
        echo -e "${WORNING} Killing benchmark...${NC}"
        sudo killall -9 zelbenchd > /dev/null 2>&1  && sleep 2
    fi
    if [[ "$daemon_status_pind" != "" ]]; then
        echo -e "${WORNING} Running daemon process detected${NC}"
        echo -e "${WORNING} Killing daemon...${NC}"
        sudo killall -9 zelcashd > /dev/null 2>&1  && sleep 2
    fi
    sudo fuser -k 16125/tcp > /dev/null 2>&1 && sleep 1
fi
if [[ -f /usr/local/bin/fluxd ]]; then
    bash -c "fluxd"
    exit
else
    bash -c "zelcashd"
    exit
fi
