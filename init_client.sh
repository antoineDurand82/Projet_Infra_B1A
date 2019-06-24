#!/bin/bash

sudo apt-get install nfs-common -y

sudo apt-get install borgbackup -y

sudo apt install python3-pip -y

sudo apt-get install python3-tk -y

chmod +x backup.sh
chmod +wxr Backup.py

echo -e "\n\nVeuillez fournir l'adresse ip de votre serveur:"
read ip_serveur

sudo echo "$ip_serveur serveurnfs">>/etc/hosts

sudo showmount -e serveurnfs

sudo mkdir /backup

touch auto.sh
chmod +x auto.sh

sudo echo "serveurnfs:/backup/ /backup nfs defaults,user,auto,noatime,bg 0 0">>/etc/fstab

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier pour avoir une backup journalière de ce dernier' \nPar exemple '/home/antoine/Desktop'. Pensez à retirer le dernier '/' se trouvant après le dernier dossier"
read cheminbackup

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier contenant le fichier 'init_client.sh' que vous venez de lancer"
read cheminfichier

sudo echo "yes | $cheminfichier/backup.sh save sauvegardeJournaliere_`date "+\%d.\%m.\%Y"` $cheminbackup">>$cheminfichier/auto.sh

sudo mv $cheminfichier/auto.sh /etc/cron.daily/

echo "Installation terminée, votre ordinateur va redémarrer dans 5 secondes"

sleep 5

sudo reboot
