#!/bin/bash
# Préparation discrète des deux noeuds avant que l'utilisateur ne commence
apt-get update -y > /dev/null 2>&1 || true
