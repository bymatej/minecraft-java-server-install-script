#!/bin/bash


Print_Message_And_Sleep "Downlading McMyAdmin" 1s
cd /usr/local
wget http://mcmyadmin.com/Downloads/etc.zip
unzip etc.zip
rm etc.zip

Print_Message_And_Sleep "Setting up iptables" 1s
iptables -A INPUT -p tcp -m tcp --dport 8080 -j ACCEPT 
iptables -A INPUT -p tcp -m tcp --dport 25565 -j ACCEPT 
iptables-save

Print_Message_And_Sleep "Done!" 1s