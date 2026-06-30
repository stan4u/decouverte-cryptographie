# Étape 2 — Création des principaux Kerberos

Toujours sur **kdc**.

## 1. Lancer l'administration Kerberos

```bash
sudo kadmin.local
```

Vous êtes maintenant dans l'invite `kadmin.local:`.

## 2. Créer un utilisateur Kerberos

```
addprinc etudiant
```

Choisissez un mot de passe (ex : `Etudiant2024!`) et confirmez-le.

## 3. Créer le principal de service pour SSH

C'est ce principal qui permettra au serveur `ssh-server` de prouver son identité auprès du KDC :

```
addprinc -randkey host/ssh-server.tp.local
```

## 4. Générer le fichier keytab

```
ktadd -k /tmp/krb5.keytab host/ssh-server.tp.local
```

Quittez `kadmin.local` :

```
quit
```

## 5. Transférer le keytab vers `ssh-server`

```bash
scp /tmp/krb5.keytab ssh-server.tp.local:/tmp/krb5.keytab
```

> Si la connexion SSH demande un mot de passe et que vous ne l'avez pas encore, c'est normal : le compte système par défaut entre les deux noeuds Killercoda accepte en général l'authentification root déjà configurée. Si besoin, utilisez `cat /tmp/krb5.keytab` sur `kdc` et recréez le fichier manuellement avec un éditeur sur `ssh-server` en base64 :
>
> ```bash
> base64 /tmp/krb5.keytab
> ```
> puis sur `ssh-server` :
> ```bash
> echo "<contenu_copié>" | base64 -d > /tmp/krb5.keytab
> ```

## Vérification

Vous devez maintenant avoir le fichier `/tmp/krb5.keytab` présent sur la machine `ssh-server`. Passez à l'étape suivante.
