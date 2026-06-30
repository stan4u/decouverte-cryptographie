# Bravo !

Vous venez de déployer une chaîne d'authentification Kerberos complète :

- Un **KDC** opérationnel gérant le royaume `TP.LOCAL`
- Un **principal utilisateur** (`etudiant`) et un **principal de service** (`host/ssh-server.tp.local`)
- Un **serveur SSH** configuré pour accepter l'authentification **GSSAPI**
- Une **connexion sans mot de passe**, validée via ticket Kerberos

## Pour aller plus loin

- Intégrer Kerberos avec LDAP pour centraliser la gestion des comptes
- Mettre en place un second KDC esclave pour la haute disponibilité
- Capturer le dialogue réseau AS-REQ/AS-REP et TGS-REQ/TGS-REP avec `tcpdump`
- Étudier la délégation de ticket (`GSSAPIDelegateCredentials`) vers un troisième service
