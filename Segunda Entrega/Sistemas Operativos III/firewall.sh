#!/bin/bash

clear

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

iptables -L -n -v

iptables -F

iptables -A INPUT -i eth0 -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -i eth0 -p tcp --dport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 3306 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o eth0 -p tcp --sport 443 -m state --state NEW,ESTABLISHED -j ACCEPT

iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT

iptables -A INPUT -p tcp --dport 22 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

iptables -A INPUT -p tcp -m iprange --src-range 192.168.1.2-192.168.1.20

iptables -A INPUT -m mac --mac-source 00:00:00:00:00:01

iptables -A INPUT -p tcp --sport 2222

iptables -A INPUT -s 192.168.0.0/24 -j DROP

iptables -A OUTPUT -d 75.126.153.206 -j DROP

iptables -A OUTPUT -p tcp -d www.facebook.com -j DROP

iptables -A OUTPUT -m mac --mac-source 00:0F:EA:91:04:08 -j DROP

iptables -A INPUT -p icmp --icmp-type echo-request -j DROP
