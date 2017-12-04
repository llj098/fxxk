CN_IP=YOUR_IP


# redirect all vpn tcp to redsocks
iptables -t nat -A PREROUTING -i ppp+ -p tcp -j DNAT --to-destination $CN_IP:12345

# redirect vpn dns to pdns
iptables -t nat -A PREROUTING -s  192.168.42.0/24  -p udp --dport 53 -j DNAT --to $CN_IP:53

# redirect all 8.8.8.8 to redsocks
iptables -A OUTPUT -p tcp -d 8.8.8.8 -j DNAT --to-destination $CN_IP:12345

# some log stuff
iptables -t nat -A PREROUTING  -s 192.168.42.0/24 -p tcp -j LOG --log-prefix "iptables:"
iptables -t nat -A INPUT  -s 192.168.42.0/24 -p tcp -j LOG --log-prefix "iptables-input:"
