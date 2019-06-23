#!/bin/bash

sudo apt-get install nfs-common -y

sudo apt-get install borgbackup -y

sudo apt install python3-pip -y

sudo apt-get install python3-tk -y

chmod +x backup.sh

echo -e "\n\nVeuillez fournir l'adresse ip de votre serveur:"
read ip_serveur

sudo echo "$ip_serveur serveurnfs">>/etc/hosts

sudo showmount -e serveurnfs

sudo mkdir /backup

touch auto.sh
chmod +x auto.sh

sudo echo "serveurnfs:/backup/ /backup nfs defaults,user,auto,noatime,bg 0 0">>/etc/fstab

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier où vous voulez avoir une backup d'un dossier particulier' \nPar exemple '/home/antoine/Desktop'. Pensez à retirer le dernier '/' se trouvant après le dernier dossier"
read cheminbackup

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier contenant le fichier que vous venez de lancer"
read cheminfichier

sudo echo "sudo cp -r /backup $cheminbackup">>$cheminfichier/auto.sh

sudo mv $cheminfichier/auto.sh /etc/cron.daily/

echo "Installation terminée, votre ordinateur va redémarrer dans 5 secondes"

sleep 5

sudo reboot