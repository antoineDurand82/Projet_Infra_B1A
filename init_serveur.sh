#!/bin/bash

sudo apt install nfs-kernel-server -y

sudo mkdir /backup

echo -e "\n\nVeuillez fournir l'adresse ip de votre client:"
read ip_client

sudo echo "$ip_client client">>/etc/hosts

sudo echo "/backup client(rw,no_root_squash)">>/etc/exports

sudo service nfs-kernel-server reload

sudo service nfs-kernel-server restart

touch auto.sh
chmod +x auto.sh

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier où vous voulez avoir une backup de votre dossier partager \nPar exemple '/home/antoine/Desktop'. Pensez à retirer le dernier '/' se trouvant après le dernier dossier"
read cheminbackup

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier contenant le fichier que vous venez de lancer"
read cheminfichier

sudo echo "sudo cp -r /backup $cheminbackup">>$cheminfichier/auto.sh

sudo mv $cheminfichier/auto.sh /etc/cron.daily/

echo -e "\n\nL'installion est terminée, bravo"