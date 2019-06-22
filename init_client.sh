#!/bin/bash

sudo apt-get install nfs-common -y

echo -e "\nVeuillez fournir l'adresse ip de votre serveur"
read ip_serveur

sudo echo "$ip_serveur serveurnfs">>/etc/hosts

sudo showmount -e serveurnfs

sudo mkdir /backup

sudo echo "serveurnfs:/backup/ /backup nfs defaults,user,auto,noatime,bg 0 0" >> /etc/fstab

sudo reboot