#!/bin/bash
# Script optionnel : automatise entièrement l'étape 1 et 2 sur le noeud "kdc".
# Usage (sur kdc) : sudo bash assets/setup-kdc.sh
set -e

REALM="TP.LOCAL"
MASTER_PW="TPkerberos2024!"
USER_PW="Etudiant2024!"

apt-get install -y krb5-kdc krb5-admin-server krb5-config

cat > /etc/krb5.conf << EOF
[libdefaults]
    default_realm = ${REALM}
    dns_lookup_realm = false
    dns_lookup_kdc = false

[realms]
    ${REALM} = {
        kdc = kdc.tp.local
        admin_server = kdc.tp.local
    }

[domain_realm]
    .tp.local = ${REALM}
    tp.local = ${REALM}
EOF

kdb5_util create -s -r "${REALM}" -P "${MASTER_PW}"

kadmin.local -q "addprinc -pw ${USER_PW} etudiant"
kadmin.local -q "addprinc -randkey host/ssh-server.tp.local"
kadmin.local -q "ktadd -k /tmp/krb5.keytab host/ssh-server.tp.local"

systemctl enable --now krb5-kdc krb5-admin-server

echo "KDC prêt. Keytab disponible dans /tmp/krb5.keytab à transférer vers ssh-server."
