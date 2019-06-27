#!/bin/bash

apt-get install nfs-common -y

apt-get install borgbackup -y

apt install python3-pip -y

apt-get install python3-tk -y

chmod +x backup.sh
chmod +wxr Backup.py

echo -e "\n\nVeuillez fournir l'adresse ip de votre serveur:"
read ip_serveur

echo "$ip_serveur serveurnfs">>/etc/hosts

showmount -e serveurnfs

mkdir /backup

touch auto.sh
chmod +x auto.sh

echo "serveurnfs:/backup/ /backup nfs defaults,user,auto,noatime,bg 0 0">>/etc/fstab

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier pour avoir une backup journalière de ce dernier' \nPar exemple '/home/antoine/Desktop'. Pensez à retirer le dernier '/' se trouvant après le dernier dossier"
read cheminbackup

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier contenant le fichier 'init_client.sh' que vous venez de lancer"
read cheminfichier

echo "yes | $cheminfichier/backup.sh save sauvegardeJournaliere_`date "+\%d.\%m.\%Y"` $cheminbackup">>$cheminfichier/auto.sh

mv $cheminfichier/auto.sh /etc/cron.daily/

mount -a -v /etc/fstab

echo "Installation terminée."

