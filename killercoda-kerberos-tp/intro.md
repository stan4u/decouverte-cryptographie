# Authentification Kerberos pour SSH

Dans ce scénario, vous allez déployer un système d'authentification **Kerberos** permettant de vous connecter à une machine virtuelle **sans mot de passe**, via le protocole **GSSAPI** intégré à SSH.

## Architecture du lab

Deux machines sont à votre disposition :

- **kdc** : le serveur Kerberos (KDC) — royaume `TP.LOCAL`
- **ssh-server** : la machine cible sur laquelle vous vous connecterez via Kerberos

Vous utiliserez également la machine `kdc` comme client pour initier la connexion SSH à la fin du TP.

## Ce que vous allez apprendre

- Installer et initialiser un Key Distribution Center (KDC)
- Créer des principaux Kerberos (utilisateur et service)
- Générer et déployer un fichier *keytab*
- Configurer SSH (client et serveur) pour utiliser GSSAPI
- Obtenir un ticket Kerberos (`kinit`) et vous authentifier sans mot de passe

Cliquez sur **Start** pour commencer.
