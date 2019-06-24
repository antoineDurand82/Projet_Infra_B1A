#!/bin/bash

apt install nfs-kernel-server -y

mkdir /backup

echo -e "\n\nVeuillez fournir l'adresse ip de votre client:"
read ip_client

echo "$ip_client client">>/etc/hosts

echo "/backup client(rw,no_root_squash)">>/etc/exports

service nfs-kernel-server reload

service nfs-kernel-server restart

touch auto.sh
chmod +x auto.sh

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier où vous voulez avoir une backup de votre dossier partager \nPar exemple '/home/antoine/Desktop'. Pensez à retirer le dernier '/' se trouvant après le dernier dossier"
read cheminbackup

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier contenant le fichier 'init_serveur.sh' que vous venez de lancer"
read cheminfichier

echo "sudo cp -r /backup $cheminbackup">>$cheminfichier/auto.sh

mv $cheminfichier/auto.sh /etc/cron.daily/

echo -e "\n\nL'installion est terminée, bravo"
