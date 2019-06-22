#!/bin/bash

sudo apt-get install nfs-kernel-server -y

sudo mkdir /backup

echo -e "\nVeuillez fournir l'adresse ip de votre client"
read ip_client

sudo echo "$ip_client client">>/etc/hosts

sudo echo "/backup client(rw,no_root_squash)"

sudo /etc/init.d/nfs-kernel-server reload

sudo /etc/init.d/nfs-kernel-server restart