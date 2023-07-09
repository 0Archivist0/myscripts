#!/bin/bash

# Function to get netstat output
function get_netstat_output() {
  sudo netstat -tuln
}

# Function to format the output
function format_output() {
  local netstat_output=$1
  local formatted_output=()

  IFS=$'\n'
  lines_tul=($netstat_output)

  for ((i=0; i<${#lines_tul[@]}; i++)); do
    local line_tul="${lines_tul[i]}"

    # Extract IP address and port from -tul output
    local ip_tul=$(echo "$line_tul" | awk '{print $5}' | cut -d ':' -f1)
    local port_tul=$(echo "$line_tul" | awk '{print $5}' | cut -d ':' -f2)

    # Extract name and MAC address
    local name=$(echo "$line_tul" | awk '{print $6}')
    local mac=$(echo "$line_tul" | awk '{print $5}')

    # Create formatted line
    if [[ $ip_tul == $ip_tuln && $port_tul == $port_tuln ]]; then
      line="$ip_tul $name $mac"
    else
      line="UNK UNK UNK"
    fi

    formatted_output+=("$line")
  done

  printf "%s\n" "${formatted_output[@]}"
}

# Check if the script is running with sudo
if [[ $EUID -ne 0 ]]; then
  echo "Please run the script with sudo or as root."
  exit 1
fi

# Get netstat output
netstat_output=$(get_netstat_output)

# Format the output
formatted_output=$(format_output "$netstat_output")

# Sort the output by IP address
sorted_output=$(echo "$formatted_output" | sort)

# Remove duplicate lines from the output
unique_output=$(echo "$sorted_output" | uniq)

# Print the formatted output
counter=1
IFS=$'\n'
for line in $unique_output; do
  echo "$counter.) $line"
  counter=$((counter+1))
done
