#################
# Rules for FW1 #
#################

####### NAT rules #######

#iptables -t nat -A POSTROUTING -o eth1 -j SNAT --to 172.32.4.100 #to be continued

####### Firewall rules #######

#Default policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

#Incoming traffic z-mail-ssh

iptables -A FORWARD -p tcp --dport 993 -d 172.31.6.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 25 -d 172.31.6.5 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -d 172.31.6.6 -j ACCEPT
iptables -A FORWARD -d 172.31.6.0/24 -j DROP

#Outgoing traffic z-mail-ssh

iptables -A FORWARD -p tcp --dport 22 -s 172.31.6.6 -j ACCEPT
iptables -A FORWARD -p tcp --dport 25 -s 172.31.6.5 -j ACCEPT
iptables -A FORWARD -s 172.31.6.0/24 -j DROP

#Incoming traffic z-http

iptables -A FORWARD -d 172.31.5.0/24 -j DROP

#Outgoing traffic z-http

iptables -A FORWARD -p tcp --dport 53 -s 172.31.5.3 -j ACCEPT  
iptables -A FORWARD -p udp --dport 53 -s 172.31.5.3 -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -s 172.31.5.4 -j ACCEPT
iptables -A FORWARD -p tcp --dport 443 -s 172.31.5.4 -j ACCEPT
iptables -A FORWARD -s 172.31.5.0/24 -j DROP

#Incoming traffic z-public

iptables -A FORWARD -p tcp --dport 80 -d 172.32.5.2 -j ACCEPT 
iptables -A FORWARD -p tcp --dport 443 -d 172.32.5.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -s 172.31.6.6 -d 172.32.5.2 -j ACCEPT
iptables -A FORWARD -p tcp --dport 53 -d 172.32.5.3 -j ACCEPT
iptables -A FORWARD -p udp --dport 53 -d 172.32.5.3 -j ACCEPT
iptables -A FORWARD -d 172.32.5.0/24 -j DROP

#Outgoing traffic z-public

iptables -A FORWARD -p tcp --dport 53 -s 172.32.5.3 -j ACCEPT  
iptables -A FORWARD -p udp --dport 53 -s 172.32.5.3 -j ACCEPT
iptables -A FORWARD -s 172.32.5.0/24 -j DROP

#Other

iptables -A FORWARD -j LOG --log-prefix "FW1 unidentified packets"
iptables -A FORWARD -j DROP
