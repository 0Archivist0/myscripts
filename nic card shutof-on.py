
import os
import sys

def user_is_admin():
    try:
        return os.getuid() == 0
    except AttributeError:
        return False

def disconnect_network_card():
    if os.name == 'posix':
        os.system("sudo ifconfig eth0 down")
    elif os.name == 'nt':
        os.system("netsh interface set interface \"Ethernet\" admin=disable")
    else:
        print("Network card disconnection not supported on this operating system.")

def reconnect_network_card():
    if os.name == 'posix':
        os.system("sudo ifconfig eth0 up")
    elif os.name == 'nt':
        os.system("netsh interface set interface \"Ethernet\" admin=enable")
    else:
        print("Network card reconnection not supported on this operating system.")

# Prompt user for operating system
os_type = input("What operating system are you using? (Windows/Linux): ")

# Check user input
if os_type.lower() == 'windows':
    os.name = 'nt'
elif os_type.lower() == 'linux':
    os.name = 'posix'
else:
    print("Operating system not supported.")
    sys.exit()

# Ask user if they want to shut down or reconnect the NIC
user_input = input("Do you want to disconnect or reconnect the NIC? (disconnect/reconnect): ")

# Check user input
if user_input.lower() == 'disconnect':
    # Disconnect the network NIC card
    if not user_is_admin():
        print("You must run this script as an administrator in order to disable network interfaces.")
        sys.exit()
    disconnect_network_card()
    print("Network card disconnected successfully.")
elif user_input.lower() == 'reconnect':
    # Reconnect the network NIC card
    if not user_is_admin():
        print("You must run this script as an administrator in order to enable network interfaces.")
        sys.exit()
    reconnect_network_card()
    print("Network card reconnected successfully.")
else:
    print("Invalid input. Exiting gracefully.")
    sys.exit()
