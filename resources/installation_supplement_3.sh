#!/bin/bash


Print_Message_And_Sleep "Installing McMyAdmin" 1s
cd /home/$username/minecraft-server
mkdir ~/McMyAdmin
cd ~/McMyAdmin
wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip
unzip MCMA2_glibc26_2.zip
rm MCMA2_glibc26_2.zip
./MCMA2_Linux_x86_64 -setpass [YOURPASSWORD] -configonly

Print_Message_And_Sleep "Done!" 1s