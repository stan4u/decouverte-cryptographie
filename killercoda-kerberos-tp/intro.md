# Déployer une authentification Kerberos pour SSH

Bienvenue dans ce TP pratique dédié à la mise en place du protocole **Kerberos** pour sécuriser et centraliser l'authentification de vos accès SSH sous Linux.

Dans un environnement de production, multiplier les clés SSH ou saisir constamment des mots de passe devient vite ingérable et risqué. Kerberos résout ce problème en introduisant un tiers de confiance qui distribue des tickets d'authentification temporaires et chiffrés.

---

## 🎯 But du TP

L'objectif de ce TP est de configurer une architecture d'authentification centralisée (Single Sign-On - SSO). À la fin de ce laboratoire, vous serez capable de vous connecter de la machine Client à la machine Serveur en tâche de fond, **sans jamais avoir à échanger de clés SSH publiques ni à taper de mot de passe SSH**.

## 🏗️ Architecture du Laboratoire

Pour ce TP, Killercoda met à votre disposition deux terminaux distincts :

1. **Serveur KDC (`controlplane`)** : 
   * Il jouera le rôle de **KDC** (Key Distribution Center), le gardien du temple Kerberos pour le royaume `LABO.LOCAL`.
   * Il fera également office de serveur SSH cible auquel nous tenterons de nous connecter.
   * *Nom de domaine configuré :* `serveur.labo.local`

2. **Client SSH (`node01`)** : 
   * C'est la machine de l'utilisateur. C'est d'ici que vous demanderez vos tickets Kerberos.
   * *Nom de domaine configuré :* `client.labo.local`

## 🧠 Ce que vous allez apprendre

* ⚙️ Configurer les prérequis indispensables à Kerberos (Résolution DNS/Hosts).
* 🏰 Installer et initialiser un serveur de clés Kerberos (KDC).
* 👤 Créer des principaux Kerberos (utilisateurs et services) et générer un fichier *keytab*.
* 🔌 Connecter SSH à Kerberos via le protocole GSSAPI.
* 🎫 Manipuler les tickets Kerberos avec les commandes `kinit`, `klist` et `kdestroy`.

---

> ⏳ **Note :** Pendant que vous lisez cette introduction, un script en arrière-plan est en train de configurer la liaison réseau et de mettre à jour les dépôts sur vos deux machines afin de vous faire gagner du temps. 

Cliquez sur le bouton **Start** dès que vous êtes prêt à commencer !