#!/bin/bash

sudo apt install nfs-kernel-server -y

sudo mkdir /backup

echo -e "\n\nVeuillez fournir l'adresse ip de votre client:"
read ip_client

sudo echo "$ip_client client">>/etc/hosts

sudo echo "/backup client(rw,no_root_squash)">>/etc/exports

sudo service nfs-kernel-server reload

sudo service nfs-kernel-server restart