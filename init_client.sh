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

sudo echo "serveurnfs:/backup/ /backup nfs defaults,user,auto,noatime,bg 0 0">>/etc/fstab

echo "Installation terminé, votre ordinateur va redémarrer dans 5 secondes"

sleep 5

sudo reboot