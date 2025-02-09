#!/bin/bash

# Linux Power Scheduling Script

# Function to schedule a shutdown on Linux
function linux_shutdown() {
echo "Scheduling a shutdown on Linux..."
if [ -z "$1" ]; then
echo "Please provide a time (in HH:MM format) for the shutdown."
exit 1
fi

shutdown_time="$1"
current_time=$(date +%H:%M)

if [[ "$shutdown_time" < "$current_time" ]]; then
echo "The time you provided has already passed. Please use a future time."
exit 1
fi

# Convert time to cron format and schedule the shutdown
cron_time=$(echo "$shutdown_time" | sed 's/:/ /')
minute=$(echo $cron_time | cut -d' ' -f2)
hour=$(echo $cron_time | cut -d' ' -f1)

(crontab -l 2>/dev/null; echo "$minute $hour * * * /sbin/shutdown -h now") | crontab -

echo "Shutdown scheduled for $shutdown_time."
}

# Function to schedule Wake-on-LAN on Linux
function linux_poweron() {
echo "Scheduling Wake-on-LAN on Linux..."
if [ -z "$1" ] || [ -z "$2" ]; then
echo "Please provide both time (HH:MM format) and MAC address for the power-on."
exit 1
fi

poweron_time="$1"
mac_address="$2"
current_time=$(date +%H:%M)

if [[ "$poweron_time" < "$current_time" ]]; then
echo "The time you provided has already passed. Please use a future time."
exit 1
fi

cron_time=$(echo "$poweron_time" | sed 's/:/ /')
minute=$(echo $cron_time | cut -d' ' -f2)
hour=$(echo $cron_time | cut -d' ' -f1)

# Schedule Wake-on-LAN (WOL)
(crontab -l 2>/dev/null; echo "$minute $hour * * * wakeonlan $mac_address") | crontab -

echo "Power-on (WOL) scheduled for $poweron_time with MAC address $mac_address."
}

# Main menu for Linux
echo "Please choose an option:"
echo "1. Schedule Linux Shutdown"
echo "2. Schedule Linux Power-on (WOL)"
echo "3. Exit"

read choice

case $choice in
1)
echo "Enter time for Linux Shutdown (HH:MM format):"
read shutdown_time
linux_shutdown $shutdown_time
;;
2)
echo "Enter time for Linux Power-on (WOL) (HH:MM format):"
read poweron_time
echo "Enter MAC address for Linux Power-on (WOL):"
read mac_address
linux_poweron $poweron_time $mac_address
;;
3)
exit 0
;;
*)
echo "Invalid option. Exiting."
exit 1
;;
esac
