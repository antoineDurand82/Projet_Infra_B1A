#!/bin/bash

action=$1
nomSauvegarde=$2
chemin=$3


#s'assurer que le dossier backup existe
if test -d /backup
    then
    echo Rappel: vos backup sont enregistrés dans /backup
    echo ''
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
    echo Extraction du contenue de la sauvegarde \"$nomSauvegarde\" en cours...
    sudo borg $action /backup::$nomSauvegarde
    echo Extraction terminée !
elif test "$action" = "delete"
    then
    echo Suppression en cours
    sudo borg $action /backup::$nomSauvegarde
    echo Votre sauvegarde \"$nomSauvegarde\" a bien été supprimée !
else
    echo erreur
fi