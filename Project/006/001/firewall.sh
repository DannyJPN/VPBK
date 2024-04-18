#!/bin/sh
#
# A simple, stateless, host-based firewall script.

# First of all, flush & delete any existing tables
sudo iptables -F
sudo iptables -X

# Deny by default (input/forward)
sudo iptables --policy INPUT DROP
sudo iptables --policy OUTPUT ACCEPT
sudo iptables --policy FORWARD DROP


sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -p tcp  -m multiport --dports 20,21,22,25,110,143,80,443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --sports 20,21,22,25,110,143,80,443 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp  -m multiport --dports 53,67,68 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp -m multiport --sports 53,67,68 -m conntrack --ctstate ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp  -m multiport --dports 53,67,68 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -p tcp -m multiport --sports 53,67,68 -m conntrack --ctstate ESTABLISHED -j ACCEPT





sudo iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT  -p icmp -m state --state ESTABLISHED,RELATED     -j ACCEPT
 




# Outgoing
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

