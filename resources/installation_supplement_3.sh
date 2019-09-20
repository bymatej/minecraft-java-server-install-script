#!/bin/bash


# Global variables
mcMyAdminPassword="";


# Sets username and password variables for McMyAdmin
function SetUsernameAndPasswordForMcMyAdmin() {
  	echo "The default username for McMyAdmin is: admin "
	echo -n "Enter the password for McMyAdmin (default: TheCakeIsALie!9999): "
	read -s mcMyAdminPassword
	mcMyAdminPassword=${mcMyAdminPassword:-TheCakeIsALie!9999}
}

# Installs mcmyadmin
function InstallMcMyAdmin() {
  	mkdir /home/$username/minecraft-server/McMyAdmin
 	cd /home/$username/minecraft-server/McMyAdmin
  	wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip
  	unzip MCMA2_glibc26_2.zip
  	rm MCMA2_glibc26_2.zip
  	./MCMA2_Linux_x86_64 -configonly
  	./MCMA2_Linux_x86_64 -setpass $mcMyAdminPassword
}

Print_Message_And_Sleep "Installing McMyAdmin" 1s
SetUsernameAndPasswordForMcMyAdmin
InstallMcMyAdmin
Print_Message_And_Sleep "Done!" 1s
