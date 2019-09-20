#!/bin/bash


# Global variables
mcMyAdminUsername="";
mcMyAdminPassword="";


# Sets username and password variables for McMyAdmin
function SetUsernameAndPasswordForMcMyAdmin(parameter) {
  echo -n "Enter the username for McMyAdmin (default: admin): "
	read mcMyAdminUsername
	mcMyAdminUsername=${mcMyAdminUsername:-admin}

	echo -n "Enter the password for McMyAdmin (default: TheCakeIsALie!9999): "
	read -s mcMyAdminPassword
	mcMyAdminPassword=${mcMyAdminPassword:-TheCakeIsALie!9999}
}

# Installs mcmyadmin
function InstallMcMyAdmin() {
  cd /home/$username/minecraft-server
  mkdir ~/McMyAdmin
  cd ~/McMyAdmin
  wget http://mcmyadmin.com/Downloads/MCMA2_glibc26_2.zip
  unzip MCMA2_glibc26_2.zip
  rm MCMA2_glibc26_2.zip
  ./MCMA2_Linux_x86_64 -setpass [YOURPASSWORD] -configonly
}

Print_Message_And_Sleep "Installing McMyAdmin" 1s
SetUsernameAndPasswordForMcMyAdmin
InstallMcMyAdmin
Print_Message_And_Sleep "Done!" 1s
