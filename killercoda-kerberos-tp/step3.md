# Étape 3 — Configuration du serveur SSH cible

Basculez sur l'onglet **ssh-server**.

## 1. Installer les paquets nécessaires

```bash
sudo apt-get install -y krb5-user openssh-server
```

Quand on vous demande le royaume par défaut, indiquez **TP.LOCAL** et le serveur KDC `kdc.tp.local`.

## 2. Copier la configuration Kerberos

```bash
sudo tee /etc/krb5.conf > /dev/null << 'EOF'
[libdefaults]
    default_realm = TP.LOCAL
    dns_lookup_realm = false
    dns_lookup_kdc = false

[realms]
    TP.LOCAL = {
        kdc = kdc.tp.local
        admin_server = kdc.tp.local
    }

[domain_realm]
    .tp.local = TP.LOCAL
    tp.local = TP.LOCAL
EOF
```

## 3. Installer le keytab reçu à l'étape précédente

```bash
sudo mv /tmp/krb5.keytab /etc/krb5.keytab
sudo chown root:root /etc/krb5.keytab
sudo chmod 600 /etc/krb5.keytab
```

Vérifiez son contenu :

```bash
sudo klist -k /etc/krb5.keytab
```

Vous devez voir une ligne contenant `host/ssh-server.tp.local@TP.LOCAL`.

## 4. Activer GSSAPI dans sshd

```bash
sudo sed -i '/^#\?GSSAPIAuthentication/d;/^#\?GSSAPICleanupCredentials/d' /etc/ssh/sshd_config
echo "GSSAPIAuthentication yes" | sudo tee -a /etc/ssh/sshd_config
echo "GSSAPICleanupCredentials yes" | sudo tee -a /etc/ssh/sshd_config
```

## 5. Redémarrer SSH

```bash
sudo systemctl restart ssh
sudo systemctl status ssh --no-pager
```

Le service doit être actif. Passez à l'étape suivante.
