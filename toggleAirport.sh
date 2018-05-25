#!/bin/bash

##
# Define wireless interface "en" label.
wifiInterface=$(networksetup -listallhardwareports | grep 'Wi-Fi' -A1 | grep -o en.)
##
# Define wireless interface active status.
wifiStatus=$(ifconfig "${wifiInterface}" | grep 'status' | awk '{ print $2 }')
##
# Define wireless interface power status
wifiPower=$(networksetup -getairportpower "${wifiInterface}" | awk '{ print $4 }')
##
# Define non-wireless interface "en" labels.
ethernetInterface=$(networksetup -listallhardwareports | grep 'en' | grep -v "${wifiInterface}" | grep -o en.)
##
# Define non-wireless IP status.
ethernetIP=$(for i1 in ${ethernetInterface};do
  echo $(ifconfig "${i1}" | grep 'inet' | grep -v '127.0.|169.254.' | awk '{ print $2 }')
done)
##
# Disable active wireless interface if non-wireless interface connected.
if [[ "${ethernetIP}" && "${wifiStatus}" = "active" ]] || [[ "${ethernetIP}" && "${wifiPower}" = "On" ]]; then
  networksetup -setairportpower "${wifiInterface}" off
  touch /var/tmp/wifiDisabled
fi
##
# Enable inactive wireless interface if previously disabled by daemon.
if [[ "${ethernetIP}" = "" && "${wifiStatus}" = "inactive" ]] || [[ "${ethernetIP}" = "" && "${wifiPower}" = "Off" ]]; then
  if [[ -f "/var/tmp/wifiDisabled" ]]; then
    rm -f /var/tmp/wifiDisabled
    networksetup -setairportpower "${wifiInterface}" on
  fi
fi
##
# Sleep to prevent launchd interpreting as a crashed process.
sleep 10
exit 0