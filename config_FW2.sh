#################
# Rules for FW2 #
#################

####### Firewall rules #######

#Default policy

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#Incoming traffic z-lweb

iptables -A FORWARD -p tcp --dport 21 -s 192.168.1.0/24 -d 10.10.2.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -s 192.168.1.0/24 -d 10.10.2.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -s 192.168.2.0/24 -d 10.10.2.2 -j ACCEPT
iptables -A FORWARD -d 10.10.2.0/24 -j DROP

#Outgoing traffic z-lweb

iptables -A FORWARD -s 10.10.2.0/24 -j DROP

#Incoming traffic z-u1

iptables -A FORWARD -p tcp --dport 22 -s 10.10.1.6 -d 192.168.1.0/24 -j ACCEPT
iptables -A FORWARD -d 192.168.1.0/24 -j DROP

#Outgoing traffic z-u1

iptables -A FORWARD -p tcp --dport 3128 -s 192.168.1.0/24 -d 10.10.1.4 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -s 192.168.1.0/24 -d 10.10.1.3 -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -s 192.168.1.0/24 -d 10.10.1.3 -j ACCEPT
iptables -A FORWARD -p tcp --dport 25 -s 192.168.1.0/24 -d 10.10.1.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 143 -s 192.168.1.0/24 -d 10.10.1.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 993 -s 192.168.1.0/24 -d 10.10.1.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -s 192.168.1.0/24 -d 10.10.1.6 -j ACCEPT
iptables -A FORWARD -p udp --dport 67 -s 192.168.1.2 -d 10.10.1.2 -j ACCEPT
iptables -A FORWARD -s 192.168.1.0/24 -j DROP

#Incoming traffic z-u2

iptables -A FORWARD -p tcp --dport 22 -s 10.10.1.6 -d 192.168.2.0/24 -j ACCEPT
iptables -A FORWARD -d 192.168.2.0/24 -j DROP

#Outgoing traffic z-u2

iptables -A FORWARD -p tcp --dport 3128 -s 192.168.2.0/24 -d 10.10.1.4 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -s 192.168.2.0/24 -d 10.10.1.3 -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -s 192.168.2.0/24 -d 10.10.1.3 -j ACCEPT
iptables -A FORWARD -p tcp --dport 25 -s 192.168.2.0/24 -d 10.10.1.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 143 -s 192.168.2.0/24 -d 10.10.1.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 993 -s 192.168.2.0/24 -d 10.10.1.5 -j ACCEPT
iptables -A FORWARD -p udp --dport 67 -s 192.168.2.2 -d 10.10.1.2 -j ACCEPT
iptables -A FORWARD -s 192.168.2.0/24 -j DROP

#Incoming traffic z-all-sandwich

iptables -A FORWARD -d 10.10.1.0/24 -j DROP

#Outgoing traffic z-all-sandwich

iptables -A FORWARD -s 10.10.1.0/24 -j DROP

#Other

iptables -A FORWARD -j LOG --log-prefix "FW2 unidentified packets"
iptables -A FORWARD -j DROP
