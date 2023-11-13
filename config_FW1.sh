###### Rules for FW1 ######

iptables -P FORWARD DROP
iptables -P INPUT DROP
iptables -P OUTPUT DROP

iptables -A -p all -s ipsource -sport sport -d ipdestination -dport dport -j ACCEPT