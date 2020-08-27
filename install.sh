#!/bin/sh

sudo apt -y update
sudo apt -y upgrade

echo "Installing required softwares ....."
sudo apt install hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd

sudo apt install dnsmasq
sudo DEBIAN_FRONTEND=noninteractive apt install -y netfilter-persistent iptables-persistent

cp routed-ap.conf /etc/sysctl.d/routed-ap.conf

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo netfilter-persistent save

sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo cp dnsmasq.conf  /etc/dnsmasq.conf

echo "Check if rf is compatable"

sudo rfkill unblock wlan

sudo cp hostapd.conf /etc/hostapd/hostapd.conf


