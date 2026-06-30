# Étape 4 — Configuration du client et test final

Revenez sur l'onglet **kdc**, qui va aussi jouer le rôle de client SSH.

## 1. Installer le client Kerberos

```bash
sudo apt-get install -y krb5-user
```

(Le `/etc/krb5.conf` est déjà en place puisque c'est la même machine que le KDC.)

## 2. Configurer le client SSH pour GSSAPI

```bash
sudo tee -a /etc/ssh/ssh_config > /dev/null << 'EOF'

Host ssh-server.tp.local
    GSSAPIAuthentication yes
    GSSAPIDelegateCredentials yes
EOF
```

## 3. Demander un ticket Kerberos (TGT)

```bash
kinit etudiant
```

Entrez le mot de passe défini à l'étape 2 (`Etudiant2024!` si vous avez suivi l'exemple).

Vérifiez le ticket obtenu :

```bash
klist
```

Vous devez voir un ticket `krbtgt/TP.LOCAL@TP.LOCAL` avec une date d'expiration.

## 4. Se connecter en SSH sans mot de passe

```bash
ssh -v etudiant@ssh-server.tp.local
```

> `etudiant` doit exister comme utilisateur système sur `ssh-server`, ou vous pouvez vous connecter en tant que `root` si Kerberos est correctement mappé. Si l'utilisateur système n'existe pas, créez-le au préalable sur `ssh-server` :
> ```bash
> sudo useradd -m etudiant
> ```

Dans la sortie verbeuse (`-v`), recherchez la ligne :

```
Authentication succeeded (gssapi-with-mic).
```

C'est la preuve que la connexion s'est faite via Kerberos, sans mot de passe.

## 5. Vérification finale

Une fois connecté, sur `ssh-server`, vérifiez le ticket de service délégué :

```bash
klist
```

Vous devez voir apparaître `host/ssh-server.tp.local@TP.LOCAL`, confirmant que l'authentification GSSAPI a fonctionné de bout en bout.

Félicitations, vous avez terminé le TP !
