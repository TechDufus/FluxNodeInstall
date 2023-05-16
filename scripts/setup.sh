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

# GLOBAL DETAILS
global_user=""

## HOST DETAILS
host_entries=()
host_ip=""
host_port=""
host_user=""
host_ansible=""
host_n=""

## NODE DETAILS
node_whiptail_title="Flux Node - "
node_entries=()
identity_key=""
collateral_tx=""
index=""
zelid=""
kadena=""
bootstrap_url=""
node_label="0"

## WATCHDOG DETAILS
watchdog_updates="0"
fix_action="0"
eps_limit="0"
discord_webhook="0"
discord_ping="0"
telegram_alert="0"
telegram_bot_token="0"
telegram_chat_id="0"

## NETWORK DETAILS
api_port=""
gateway=""

if [[ -f "./scripts/hosts.ini" ]]; then
  echo -e "Removing previous default host file ... "
  rm ./scripts/hosts.ini
fi

if [[ -f "./scripts/default_vars_new.yml" ]]; then
  echo -e "Removing previous default vars file ... "
  rm ./scripts/default_vars_new.yml
fi

function generate_host(){
  host_entry=""
  host_entry="$USER ansible_host=$host_ip user=$host_user n=t$1"

  if [[ "$host_ansible" != "" ]]; then
    host_entry="$host_entry ansible_user=$host_ansible"
  fi

  if [[ "$ansible_port" != "" ]]; then
    host_entry="$host_entry ansible_port=$host_port"
  fi

  if [[ "$api_port" != "" ]]; then
    host_entry="$host_entry apiport=$api_port gateway=$gateway"
  fi
  host_entries+=("$host_entry")
}

function generate_node_details(){
  node_entry=""
  node_entry=$(cat <<- EOF
    t$i:
      collateral_tx: '$collateral_tx'
      index: '$index'
EOF
  )
  node_entries+=("$node_entry")
}

function generate_host_file(){
  echo "[ALL]" > ./scripts/hosts.ini
  for host_entry in "${host_entries[@]}"; do
    echo "$host_entry" >> ./scripts/hosts.ini
  done
}

function generate_var_file(){
  if [[ "$host_ansible" != "" ]]; then
    global_user="$host_ansible"
  else
    global_user="$host_user"
  fi

  echo "global:
  user: $global_user

user:
  $host_user:
    zelid: $zelid
    kda: $kadena
    identity_key: '$identity_key'
    watchdog:
      flux_update: '$flux_update'
      daemon_update: '$daemon_update'
      bench_update: '$bench_update'
      eps_tier: '$eps_limit'
      discord_webhook: '$discord_webhook'
      discord_ping: '$discord_ping'
      telegram_alert: '$telegram_alert'
      telegram_bot_token: '$telegram_bot_token'
      telegram_chat_id: '$telegram_chat_id'" > ./scripts/user.yml

  for node_entry in "${node_entries[@]}"; do
    echo "$node_entry" >> ./scripts/user.yml
  done
}

function gather_host_details(){
  echo -e "${ARROW} ${YELLOW}Gathering Host Details for node $(($1+1)) ${NC}"
  sleep 2
  attempt=0
  while true
  do
    host_ip=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "Enter your Flux Node's IP Address" 8 65 3>&1 1>&2 2>&3)
    host_user=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "Enter your Flux Node username" 8 72 3>&1 1>&2 2>&3)
    host_ansible=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "(Optional) Enter your Ansible SSH username (Default is ${USER}). This is the user that Ansible will SSH into the node with." 8 72 3>&1 1>&2 2>&3)
    host_port=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "(Optional) Enter your Ansible SSH port (Default is 22)" 8 65 3>&1 1>&2 2>&3)
    # This is just to display the default values but the vars themselves are not changed
    if [[ "$host_port"    == "" ]]; then display_host_port="22"; fi
    if [[ "$host_ansible" == "" ]]; then display_host_ansible="$USER"; fi

    if whiptail --yesno "Are these details correct?\n
    Host IP: $host_ip\n
    Host User: $host_user\n
    Ansible User: $display_host_ansible\n
    Host Port: $display_host_port" 15 100; then
      echo -e "${ARROW} ${CYAN}Host IP:      ${GREEN}$host_ip${CYAN}\t ...... [${CHECK_MARK}${CYAN}]${NC}"
      echo -e "${ARROW} ${CYAN}Host User:    ${GREEN}$host_user${CYAN}\t ...... [${CHECK_MARK}${CYAN}]${NC}"
      echo -e "${ARROW} ${CYAN}Ansible User: ${GREEN}$display_host_ansible${CYAN}\t ...... [${CHECK_MARK}${CYAN}]${NC}"
      echo -e "${ARROW} ${CYAN}Host Port:    ${GREEN}$display_host_port${CYAN}\t ...... [${CHECK_MARK}${CYAN}]${NC}"
      sleep 1
      break
    else
      attempt=$((attempt+1))
      if [ $attempt -gt 2 ]; then
        echo -e "${ARROW} ${CYAN}Maximum attempts exceeded ...... exiting script[${X_MARK}${CYAN}]${NC}"
        exit
      fi
      echo -e "${ARROW} ${CYAN}Details are not confirmed ...... attempt $attempt/3[${X_MARK}${CYAN}]${NC}"
      sleep 3
    fi
  done
}

function gather_flux_details(){
  echo -e "${ARROW} ${YELLOW}Gathering Node Details for node $(($1+1))${NC}"
  sleep 2
  attempt=0
  while true
  do
    identity_key=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "Enter your FluxNode Identity Key from Zelcore" 8 65 3>&1 1>&2 2>&3)
    collateral_tx=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "Enter your FluxNode Collateral TX ID from Zelcore" 8 72 3>&1 1>&2 2>&3)
    index=$(whiptail --title "${node_whiptail_title}$(($1+1))" --inputbox "Enter your FluxNode Output Index from Zelcore" 8 65 3>&1 1>&2 2>&3)

    if whiptail --yesno "Are these details correct?\n
    Identity Key: $identity_key\n
    Collateral TX: $collateral_tx\n
    Output Index: $index" 13 100; then
      echo -e "${ARROW} ${CYAN}Identity Key:  ${GREEN}$identity_key${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
      echo -e "${ARROW} ${CYAN}Collateral TX:  ${GREEN}$collateral_tx${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
      echo -e "${ARROW} ${CYAN}Output Index: ${GREEN}$index${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
      sleep 1
      break
    else
      attempt=$((attempt+1))
      if [ $attempt -gt 2 ]; then
        echo -e "${ARROW} ${CYAN}Maximum attempts exceeded ...... exiting script[${X_MARK}${CYAN}]${NC}"
        exit
      fi
      echo -e "${ARROW} ${CYAN}Details are not valid ...... attempt $attempt/3[${X_MARK}${CYAN}]${NC}"
      sleep 3
    fi
  done
}

function gather_upnp_details(){
  if whiptail --yesno "Would you like to enable upnp for ${node_whiptail_title}$(($1+1))?" 8 72; then
    attempt=0
    while true
    do
      api_port=$(whiptail --title "Enter your FluxOS UPnP Port - ${node_whiptail_title}$(($1+1))" --radiolist \
        "Use the UP/DOWN arrows to highlight the port you want. Press Spacebar on the port you want to select, THEN press ENTER." 17 50 8 \
        "16127" "" ON \
        "16137" "" OFF \
        "16147" "" OFF \
        "16157" "" OFF \
        "16167" "" OFF \
        "16177" "" OFF \
        "16187" "" OFF \
        "16197" "" OFF 3>&1 1>&2 2>&3)
      gateway=$(whiptail --inputbox "Enter your FluxNode Network Gateway IP - ${node_whiptail_title}$(($1+1))" 8 72 3>&1 1>&2 2>&3)

      if whiptail --yesno "Are these details correct?\n
      Node UPnP API Port: $api_port\n
      Node UPnP Gateway IP: $gateway" 13 100; then
        echo -e "${ARROW} ${CYAN}Node UPnP API Port:  ${GREEN}$api_port${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
        echo -e "${ARROW} ${CYAN}Node UPnP Gateway IP  ${GREEN}$gateway${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
        sleep 1
        break
      else
        attempt=$((attempt+1))
        if [ $attempt -gt 2 ]; then
          echo -e "${ARROW} ${CYAN}Maximum attempts exceeded ...... exiting script[${X_MARK}${CYAN}]${NC}"
          exit
        fi
        echo -e "${ARROW} ${CYAN}User failed to confirm details ...... attempt $attempt/3[${X_MARK}${CYAN}]${NC}"
        sleep 3
      fi
    done
  else
    echo -e "${ARROW} ${CYAN}UPnP Disabled: ...... [${X_MARK}${CYAN}]${NC}"
  fi
}

function gather_node_type(){
  echo -e "${ARROW} ${YELLOW}Gathering Watchdog Node Type for node $(($1+1))${NC}"
  sleep 3
  eps_limit=$(whiptail --title "Select Node Type - node $(($1+1))" --radiolist \
  "Use the UP/DOWN arrows to highlight the port you want. Press Spacebar on the port you want to select, THEN press ENTER." 17 50 4 \
  "90" "CUMULUS" ON \
  "180" "NIMBUS" OFF \
  "300" "STRATUS" OFF 3>&1 1>&2 2>&3)

  [ $eps_limit ] && echo -e "${ARROW} ${CYAN}EPS Limit:  ${GREEN}$eps_limit${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}" || \
    echo -e "${ARROW} ${CYAN}EPS Limit Not Set ...... [${X_MARK}${CYAN}]${NC}"
}

if ! bc -v > /dev/null 2>&1 ; then
  echo -e "${ARROW} ${YELLOW}Installing BC ....${NC}"
  sudo apt install -y bc > /dev/null 2>&1 && sleep 1
  echo
fi

echo -e "${ARROW} ${YELLOW}Gathering Setup Details${NC}"

num_nodes=$(whiptail --title "Number of Nodes for host" --radiolist \
      "Use the UP/DOWN arrows to highlight the number of nodes you wish to setup. Press Spacebar on the port you want to select, THEN press ENTER." 17 50 8 \
      "1" "" ON \
      "2" "" OFF \
      "3" "" OFF \
      "4" "" OFF \
      "5" "" OFF \
      "6" "" OFF \
      "7" "" OFF \
      "8" "" OFF 3>&1 1>&2 2>&3)

if [[ "$num_nodes" = "0" || "$num_nodes" = "" ]]; then
  echo -e "${ARROW} ${RED}Number of nodes not valid ...... exiting script${CYAN}[${X_MARK}${CYAN}]${NC}"
  exit
fi

for ((i=0; i<"$num_nodes"; i++)); do
  echo -e "${ARROW} ${CYAN}Number of Nodes for host: $((i+1)) of ${GREEN}$num_nodes${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"

  gather_host_details $i
  gather_flux_details $i
  gather_node_type $i
  gather_upnp_details $i

  generate_host $i
  generate_node_details $i
done

attempt=0
while true
do
  zelid=$(whiptail --title "Flux Configuration" --inputbox "Enter your ZEL ID from ZelCore (Apps -> Zel ID (CLICK QR CODE)) " 8 72 3>&1 1>&2 2>&3)
  if [ $(printf "%s" "$zelid" | wc -c) -eq "34" ] || [ $(printf "%s" "$zelid" | wc -c) -eq "33" ]; then
      echo -e "${ARROW} ${CYAN}Zel ID: ${GREEN}$zelid${CYAN} is valid ...... [${CHECK_MARK}${CYAN}]${NC}"
      break
  else
    attempt=$((attempt+1))
    if [ $attempt -gt 2 ]; then
      echo -e "${ARROW} ${CYAN}Maximum attempts exceeded ...... exiting script[${X_MARK}${CYAN}]${NC}"
      exit
    fi
    echo -e "${ARROW} ${CYAN}Zel ID ${RED}$zelid${CYAN} is not valid try again ...... attempt $attempt/3[${X_MARK}${CYAN}]${NC}"
    sleep 3
  fi
done

if whiptail --yesno "Would you like to use a custom daemon bootstrap URL (Recommended: No)" 8 72; then
  bootstrap_url=$(whiptail --inputbox "Enter your preferred daemon bootstrap URL" 8 85 3>&1 1>&2 2>&3)
else
  bootstrap_url=""
fi
echo -e "${ARROW} ${CYAN}Bootstrap URL: ${GREEN}$bootstrap_url${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
sleep 2

echo -e "${ARROW} ${YELLOW}Gathering Watchdog Auto Update Details${NC}"
sleep 3
attempt=0
while true
do
  whiptail --yesno "Would you like to enable FluxOS auto updates?" 8 65 3>&1 1>&2 2>&3 && flux_update="1" || flux_update="0"
  whiptail --yesno "Would you like to enable Flux Daemon auto updates?" 8 65 3>&1 1>&2 2>&3 && daemon_update="1" || daemon_update="0"
  whiptail --yesno "Would you like to enable Flux Bench updates?" 8 65 3>&1 1>&2 2>&3 && bench_update="1" || bench_update="0"

  if whiptail --yesno "Are these details correct?\n
  FluxOS Update: $([ "$flux_update" = "1" ] && echo true || echo false)\n
  Flux Daemon Update: $([ "$daemon_update" = "1" ] && echo true || echo false)\n
  Flux Bench Update: $([ "$bench_update" = "1" ] && echo true || echo false)" 13 100; then
    echo -e "${ARROW} ${CYAN}FluxOS Update: $([ "$flux_update" = "1" ] && echo "[${CHECK_MARK}${CYAN}]" || echo "[${X_MARK}${CYAN}]")${NC}"
    echo -e "${ARROW} ${CYAN}Flux Daemon Update:  $([ "$daemon_update" = "1" ] && echo "[${CHECK_MARK}${CYAN}]" || echo "[${X_MARK}${CYAN}]")${NC}"
    echo -e "${ARROW} ${CYAN}Flux Bench Update: $([ "$bench_update" = "1" ] && echo "[${CHECK_MARK}${CYAN}]" || echo "[${X_MARK}${CYAN}]")${NC}"
    sleep 1
    break
  else
    attempt=$((attempt+1))
    if [ $attempt -gt 2 ]; then
      echo -e "${ARROW} ${CYAN}Maximum attempts exceeded ...... exiting script${CYAN}[${X_MARK}${CYAN}]${NC}"
      exit
    fi
    echo -e "${ARROW} ${CYAN}User failed to confirm details ...... attempt $attempt/3${CYAN}[${X_MARK}${CYAN}]${NC}"
    sleep 3
  fi
done

echo -e "${ARROW} ${YELLOW}Gathering Watchdog Discord Details${NC}"
sleep 3
if whiptail --yesno "Would you like to enable Discord pings?" 8 65 3>&1 1>&2 2>&3; then
  attempt=0
  while true
  do
    discord_ping=$(whiptail --inputbox "Please enter your Disord ID?" 8 65 3>&1 1>&2 2>&3)
    discord_webhook=$(whiptail --inputbox "Please enter your Discord webhook" 8 85 3>&1 1>&2 2>&3)

    if whiptail --yesno "Are these details correct?\n
    Discord Ping ID: $discord_ping\n
    Discord Webhook URL: $discord_webhook" 13 100; then
      echo -e "${ARROW} ${CYAN}Discord Ping ID:  ${GREEN}$discord_ping${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
      echo -e "${ARROW} ${CYAN}Discord Webhook URL:  ${GREEN}$discord_webhook${CYAN} ...... [${CHECK_MARK}${CYAN}]${NC}"
      break
    else
      attempt=$((attempt+1))
      if [ $attempt -gt 2 ]; then
        echo -e "${ARROW} ${CYAN}Maximum attempts exceeded ...... exiting script[${X_MARK}${CYAN}]${NC}"
        exit
      fi
      echo -e "${ARROW} ${CYAN}User failed to confirm details ...... attempt $attempt/3[${X_MARK}${CYAN}]${NC}"
      sleep 3
    fi
  done
else
  echo -e "${ARROW} ${CYAN}Discord Notifications Disabled: ...... [${X_MARK}${CYAN}]${NC}"
fi

############## FILE GENERATION HAPPENS HERE ###########
echo -e "${ARROW} ${GREEN}Generating host file .................. [${CHECK_MARK}${CYAN}]${NC}"
generate_host_file

echo -e "${ARROW} ${GREEN}Generating user var file .................. [${CHECK_MARK}${CYAN}]${NC}"
generate_var_file
