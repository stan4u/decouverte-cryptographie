# Etape 1 : Installation et initialisation du KDC

Le **KDC** (Key Distribution Center) est le coeur de Kerberos. C'est lui qui va stocker les comptes de nos utilisateurs et générer les précieux tickets d'accès. Nous allons l'installer sur le terminal **Serveur KDC** (`controlplane`).

### 1. Installer le serveur Kerberos

Cliquez sur la commande suivante pour lancer l'installation des paquets requis sur le **Serveur KDC** :

```
apt-get install -y krb5-kdc krb5-admin-server
```{{exec}}

> ⚠️ **ATTENTION :**
> Pendant l'installation, des fenêtres de configuration vont apparaître dans votre terminal. 
> * Utilisez la touche **Tab** pour déplacer le curseur sur `<Ok>`.
> * Utilisez la touche **Entrée** pour valider.
>
> Remplissez les champs exactement avec ces valeurs :
> 1. **Default Kerberos version 5 realm :** `LOCAL` *(Impérativement en MAJUSCULES)*
> 2. **Kerberos servers for your realm :** `kdc.local`
> 3. **Administrative server for your Kerberos realm :** `kdc.local`

### 2. Créer la base de données Kerberos

Le serveur a maintenant besoin d'initialiser sa base de données chiffrée qui contiendra les futurs utilisateurs et leurs clés de sécurité.

Exécutez la commande suivante :
```
kdb5_util create -s 
```{{exec}}

> Le système va vous demander un *Master Key password*. Choisissez un mot de passe (par exemple `TPkerberos2026!`) et confirmez-le.

### 3. Démarrer les services Kerberos

maintenant que la base de données est crée, démarrez tous les services Kerberos :
```
systemctl start krb5-kdc krb5-admin-server
systemctl enable krb5-kdc krb5-admin-server
```{{exec}}

### 4. Vérification

Assurez-vous que le serveur Kerberos tourne correctement sur la machine `controlplane` :
```
systemctl status krb5-kdc --no-pager
```{{exec}}

Si vous voyez active (running) s'afficher en vert, votre serveur Kerberos est officiellement prêt à distribuer ses premiers tickets !

Cliquez sur **Next** pour passer à la création des utilisateurs.