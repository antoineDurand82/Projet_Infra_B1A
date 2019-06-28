#!/bin/bash

action=$1
nomSauvegarde=$2
chemin=$3


#s'assurer que le dossier backup existe
if test -d /backup
    then
    if test -f /backup/config
        then
        echo Rappel: vos backup sont enregistrés dans /backup
        echo ''
    else 
        echo Vos backup seront enregistré dans /backup
        echo ''
        borg init -e none /backup
    fi
else
    echo Vos backup seront enregistré dans /backup
    echo ''
    borg init -e none /backup
fi

if ! test -f /nePasSupprimer
    then
    touch /nePasSupprimer  
fi


#action réalisé en fonction des paramètres
if test "$action" = "save"
    then
    echo Sauvegarde en cours...
    borg create /backup::$nomSauvegarde $chemin
    echo $nomSauvegarde';'$chemin>>/nePasSupprimer
    echo Sauvegarde Effectuée !
elif test "$action" = "list"
    then
    borg $action /backup
elif test "$action" = "extract"
    then
    echo Extraction du contenue du backup \"$nomSauvegarde\" en cours...
    borg $action /backup::$nomSauvegarde
    echo Extraction terminée !
elif test "$action" = "restore" && ! test -z $nomSauvegarde
    then
    echo Restoration du contenue du backup \"$nomSauvegarde\" en cours...
    nombreslash=$(grep $nomSauvegarde /nePasSupprimer | cut -d';' -f2 | grep -o "/" | wc -l)
    let nombreslash+=1
    dernierdossier=$(grep $nomSauvegarde /nePasSupprimer | cut -d';' -f2 | grep "/" | cut -d'/' -f$nombreslash)
    chemincomplet=$(grep $nomSauvegarde /nePasSupprimer | cut -d';' -f2)
    retrouverChemin=${#dernierdossier}
    let retrouverChemin+=1
    cheminVoulu=${chemincomplet::-$retrouverChemin}
    if test -z $cheminVoulu
        then
        cheminVoulu='/'
    fi
    cheminVoulu2="${cheminVoulu:1}"
    cd $cheminVoulu
    rm -rf $dernierdossier
    borg extract /backup::$nomSauvegarde
    if test $cheminVoulu != '/'
        then
        cd $cheminVoulu2
        mv $dernierdossier $cheminVoulu
        cd $cheminVoulu
        suppressionRelou=$(grep $nomSauvegarde /nePasSupprimer | cut -d';' -f2 | cut -d'/' -f2)
        rm -rf $suppressionRelou
    fi
    echo Restoration terminée !
elif test "$action" = "delete"
    then
    if test "$nomSauvegarde" = "all"
        then
        echo Suppression en cours...
        borg $action /backup
        echo Tous vos backup ont bien été supprimés !
    else
        echo Suppression en cours...
        borg $action /backup::$nomSauvegarde
        sed -i /$nomSauvegarde/d /nePasSupprimer
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
    echo -e "\n Pour restaurer votre backup "
    echo "./backup.sh restore nom_de_votre_backup"
    echo -e "\n Pour supprimer le backup de votre choix:"
    echo "./backup.sh delete nom_de_votre_backup"
    echo -e "\n Pour supprimer tous vos backup:"
    echo "./backup.sh delete all "
else
    echo Erreur: Il y a un problème au niveau des arguments donnés. Rajoutez -h ou --help pour obtenir de l\'aide. Plus d\'informations sur notre documentation d\'utilisation.
fi
