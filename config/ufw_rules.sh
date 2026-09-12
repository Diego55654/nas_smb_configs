#!/bin/bash
# ==============================================================================
# Script de Configuração do Firewall (UFW) - HomeLab NAS
# ==============================================================================

echo "[+] Resetando regras padrão do UFW..."
sudo ufw --force reset

# Política Padrão:
sudo ufw default deny incoming #Bloqueia tudo que entra
sudo ufw default allow outgoing #Permite tudo que sai

echo "[+] Aplicando regras de portas..."

# 1. SSH em porta customizada
sudo ufw allow 2525/tcp comment 'Acesso SSH Customizado'

# 2. Interface Virtual do Tailscale (Acesso Remoto Seguro)
sudo ufw allow in on tailscale0 comment 'Rede Tailscale'

# 3. Portas do Samba liberadas APENAS para a Subnet Local da Casa
sudo ufw allow from 192.168.22.0/24 to any port 139 proto tcp comment 'Samba NetBIOS PS2'
sudo ufw allow from 192.168.22.0/24 to any port 445 proto tcp comment 'Samba SMB PS2'

# Ativação do Firewall
echo "[+] Ativando UFW..."
sudo ufw --force enable

echo "[+] Status do Firewall:"
sudo ufw status verbose
