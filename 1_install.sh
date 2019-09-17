#!/bin/bash


# Downloads and installs the server ToDo: extract to one big zip file and download from only one source from own hosting
function Download_And_Install_Server() {
    wget https://launcher.mojang.com/v1/objects/3dc3d84a581f14691199cf6831b71ed1296a9fdf/server.jar -O minecraft_server.1.14.4.jar
    cd minecraft-server
    touch run.sh
    echo "java -Xmx1280M -Xms1024M -jar minecraft_server.1.14.4.jar nogui" > run.sh
    chmod +x run.sh
}

# Create directory structure for installation
function Create_Directories_For_Installation() {
	Print_Message_And_Sleep "Creating directory structure..." 0s
	cd /home/$username
	mkdir minecraft-server
	cd minecraft-server
}

if Has_Internet_Connection -eq 1; then
	Print_Message_And_Sleep "Fix your internet connection issues and rerun the script!" 5s
	exit;
fi
Create_Directories_For_Installation
Download_And_Install_Server
# todo: delete archive files after instalation
Print_Message_And_Sleep "Matej's Minecraft Java Edition Server script has finished successfully!" 1s
Print_Message_And_Sleep "Login as $username user and go to ~/minecraft-server/ directory and run run.sh command. Then, agree to EULA (follow instructions) and edit server.properties as desired." 5s
Print_Message_And_Sleep "After you are done with the setup run the run.sh shell with screen command like this: screen ./run.sh"
exit