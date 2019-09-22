#!/bin/bash


# Global variables
username="";
password="";


# Checks if the script is run as root
function Exit_If_Not_Root() {
    if [ "$EUID" -ne 0 ]; then
        echo "Please run this script as root"
        exit
    fi
}

# Checks if the current user is the one that was created for installation
function Exit_If_Wrong_User() {
	currentUser=$(whoami)
	if [ $currentUser != $username ]; then
		echo "Wrong user! Script must be executed by the user $username"
		exit
	fi
}

# Checks if you have access to internet (checks Google DNS availability)
function Has_Internet_Connection() {
	nc -z 8.8.8.8 53  > /dev/null 2>&1
	online=$?
	if [ $online -eq 0 ]; then
	    echo "Awesome! This machine has internet connection!"
	    return 1
	else
	    echo "This machine is Offline."
	    return 0
	fi
}

# Prints out the message and waits
function Print_Message_And_Sleep() {
    echo $1
    sleep $2 # wait for X seconds before the next command is executed
}

# Prepare user for installation
function Prepare_System_For_Installation() {
	Print_Message_And_Sleep "Downloading required files..." 1s
	sudo apt --assume-yes update
	sudo apt --assume-yes install openjdk-8-jre-headless screen

	Print_Message_And_Sleep "Create the user that will be used for Minecraft Java Edition server" 1s

	echo -n "Enter the username (default: minecraft): "
	read username
	username=${username:-minecraft}

	echo -n "Enter the password (default: TheCakeIsALie!9999): "
	read -s password
	password=${password:-TheCakeIsALie!9999}

	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "User $username already exists!"
		exit
	fi

	sudo adduser $username --gecos "Minecraft, , , " --disabled-password # Add the specified user with all the details
	#echo "$password" | passwd "$username" --stdin
	echo $username:$password | sudo chpasswd
}


# Phase 1 - prepare
if Has_Internet_Connection -eq 1; then
	Print_Message_And_Sleep "Fix your internet connection issues and rerun the script!" 5s
	exit;
fi
Exit_If_Not_Root Print_Message_And_Sleep "Matej's Minecraft Java Edition Server installation script has started" 2s
Prepare_System_For_Installation
Print_Message_And_Sleep "Preparation finished!" 2s
export -f Print_Message_And_Sleep
export -f Has_Internet_Connection
export username
currentDir=$(pwd)
# Phase 2 - install resources
/bin/su -m -c "source $currentDir/resources/installation_supplement_1.sh" - $username # download Minecraft server as minecraft user
source $currentDir/resources/installation_supplement_2.sh # Download McMyAdmin and open port 8080 as sudo
/bin/su -m -c "source $currentDir/resources/installation_supplement_3.sh" - $username # Install McMyAdmin as minecraft user
# Phase 3 - exit
Print_Message_And_Sleep "#################" 1s
Print_Message_And_Sleep "All done!" 1s
#Print_Message_And_Sleep "Login as $username user and go to ~/minecraft-server/ directory and run run.sh command. Then, agree to EULA (follow instructions!!!) and then edit server.properties as desired." 5s
Print_Message_And_Sleep "Go to /home/$username/minecraft-server/McMyAdmin/ and run ./MCMA2_Linux_x86_64 to fire up your server."
 Print_Message_And_Sleep "Go to http://localhost:8080 and log in with your McMyAdmin username and password, and configure your server!" 5s
Print_Message_And_Sleep "Default username is admin and default password is admin. MAKE SURE YOU CHANGE YOUR PASSWORD!" 5s
Print_Message_And_Sleep "For more information please refer to this website: https://bymatej.com/" 5s
exit

# To delete the user and it's home directory run this command: sudo userdel -f -r minecraft
# This works for newly created user, and in example above we used the username "minecraft"
# Use this command with caution
