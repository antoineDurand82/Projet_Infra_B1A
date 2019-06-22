#!/bin/bash

action=$1
nomSauvegarde=$2
chemin=$3


#s'assurer que le dossier backup existe
if test -d /backup
    then
    if sudo test -f /backup/config
        then
        echo Rappel: vos backup sont enregistrés dans /backup
        echo ''
    else 
        echo fdp tu me casse les couilles
        echo Vos backup seront enregistré dans /backup
        echo ''
        sudo borg init -e none /backup
    fi
else
    echo Vos backup seront enregistré dans /backup
    echo ''
    sudo borg init -e none /backup
fi


#action réalisé en fonction des paramètres
if test "$action" = "save"
    then
    echo Sauvegarde en cours...
    sudo borg create /backup::$nomSauvegarde $chemin
    echo Sauvegarde Effectuée !
elif test "$action" = "list"
    then
    sudo borg $action /backup
elif test "$action" = "extract"
    then
    echo Extraction du contenue du backup \"$nomSauvegarde\" en cours...
    sudo borg $action /backup::$nomSauvegarde
    echo Extraction terminée !
elif test "$action" = "delete"
    then
    if test "$nomSauvegarde" = "all"
        then
        echo Suppression en cours...
        sudo borg $action /backup
        echo Tous vos backup ont bien été supprimés !
    else
        echo Suppression en cours...
        sudo borg $action /backup::$nomSauvegarde
        echo Votre backup \"$nomSauvegarde\" a bien été supprimé !
    fi
elif test "$action" = "-h" || test "$action" = "--help"
    then
    echo Pour utiliser ce script, écrivez: 
    echo -e "\n Pour enregistrer un backup: "
    echo "./backup.sh save nom_de_votre_backup chemin_du_backup "
    echo -e "\n Pour lister tous vos backup enregistrés:"
    echo "./backup.sh list "
    echo -e "\n Pour extraire votre backup dans le répertoire courant:"
    echo "./backup.sh extract nom_de_votre_backup"
    echo -e "\n Pour supprimer le backup de votre choix:"
    echo "./backup.sh delete nom_de_votre_backup"
    echo -e "\n Pour supprimer tous vos backup:"
    echo "./backup.sh delete all "
else
    echo Erreur: Il y a un problème au niveau des arguments donnés. Rajoutez -h ou --help pour obtenir de l\'aide. Plus d\'informations sur notre documentation d\'utilisation.
fi