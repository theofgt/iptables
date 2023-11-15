#################
# Rules for FW3 #
#################

####### Firewall rules #######

iptables -F

#Default policy

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#Incoming traffic z-nfs

iptables -A FORWARD -p tcp --dport 111 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p udp --dport 111 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 2046 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p udp --dport 2046 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 2047 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p udp --dport 2047 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 2048 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p udp --dport 2048 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 2049 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT
iptables -A FORWARD -p udp --dport 2049 -s 192.168.3.2 -d 10.10.3.2 -j ACCEPT 
iptables -A FORWARD -p tcp --dport 873 -s 192.168.3.3 -d 10.10.3.3 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -s 192.168.3.3 -d 10.10.3.3 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -s 10.10.4.6 -d 10.10.3.3 -j ACCEPT
iptables -A FORWARD -d 10.10.3.0/24 -j DROP

#Outgoing traffic z-nfs

iptables -A FORWARD -s 10.10.3.0/24 -j DROP

#Incoming traffic z-u3

iptables -A FORWARD -p tcp --dport 22 -s 10.10.4.6 -d 192.168.3.2 -j ACCEPT
iptables -A FORWARD -d 192.168.3.0/24 -j DROP

#Outgoing traffic z-u3

iptables -A FORWARD -p tcp --dport 22 -s 192.168.3.3 -d 10.10.4.6 -j ACCEPT
iptables -A FORWARD -s 192.168.3.0/24 -j DROP

#Incoming traffic z-ssh

iptables -A FORWARD -d 10.10.4.0/24 -j DROP

#Outgoing traffic z-ssh

iptables -A FORWARD -s 10.10.4.0/24 -j DROP

#Other

iptables -A FORWARD -j LOG --log-prefix "FW3 unidentified packets"
iptables -A FORWARD -j DROP
