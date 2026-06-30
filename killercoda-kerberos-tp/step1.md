# Étape 1 — Installation du KDC

Tout se passe d'abord sur le noeud **kdc** (onglet de gauche).

## 1. Récupérer le nom d'hôte réel de chaque machine

Les noms d'hôtes attribués par la plateforme ne sont pas forcément `kdc` / `ssh-server` en interne. Récupérez-les :

```bash
hostname -f
```

Notez ce nom, ainsi que celui de la machine `ssh-server` (à exécuter sur l'autre onglet) — vous en aurez besoin pour `/etc/hosts`.

## 2. Renseigner la résolution de noms

Sur **les deux machines**, ajoutez l'entrée de l'autre machine dans `/etc/hosts` :

```bash
echo "$(getent hosts ssh-server | awk '{print $1}') ssh-server.tp.local ssh-server" | sudo tee -a /etc/hosts
```

> Si `getent` ne résout pas directement `ssh-server`, utilisez l'adresse IP visible avec `ip a` sur la machine `ssh-server`.

## 3. Installer le KDC

Sur **kdc** :

```bash
sudo apt-get install -y krb5-kdc krb5-admin-server krb5-config
```

Lors de l'invite interactive, indiquez le royaume **TP.LOCAL**.

## 4. Configurer `/etc/krb5.conf`

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

## 5. Créer la base Kerberos

```bash
sudo krb5_newrealm
```

Choisissez un mot de passe master (par exemple `TPkerberos2024!`) et notez-le.

## 6. Démarrer les services

```bash
sudo systemctl enable --now krb5-kdc krb5-admin-server
sudo systemctl status krb5-kdc --no-pager
```

Vous devez voir le service actif (`active (running)`).
