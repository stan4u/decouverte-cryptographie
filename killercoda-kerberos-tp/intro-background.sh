#!/bin/bash

# 1. Récupération dynamique des adresses IP privées de Killercoda
IP_SERVER=$(ip route get 1.1.1.1 | awk '{print $7; exit}')
IP_CLIENT=$(ssh node01 "ip route get 1.1.1.1" | awk '{print $7; exit}')

# 2. Configuration du fichier /etc/hosts sur le Serveur (controlplane)
echo "" >> /etc/hosts
echo "# Configuration du TP Kerberos" >> /etc/hosts
echo "$IP_SERVER serveur.labo.local serveur" >> /etc/hosts
echo "$IP_CLIENT client.labo.local client" >> /etc/hosts

# 3. Configuration du fichier /etc/hosts sur le Client (node01) via SSH
ssh node01 "echo '' >> /etc/hosts"
ssh node01 "echo '# Configuration du TP Kerberos' >> /etc/hosts"
ssh node01 "echo '$IP_SERVER serveur.labo.local serveur' >> /etc/hosts"
ssh node01 "echo '$IP_CLIENT client.labo.local client' >> /etc/hosts"

# 4. Pré-mise à jour des paquets en tâche de fond pour accélérer l'installation
apt-get update -y
ssh node01 "apt-get update -y"

# 5. Création d'un flag pour signaler au TP que la configuration est prête
touch /tmp/background-finished
ssh node01 "touch /tmp/background-finished"