# Configuração do OPL (Open PS2 Loader)

Aqui mostro o preenchimento dos parâmetros de rede no PlayStation 2 para conexão direta com o servidor NAS via cabo Ethernet.
Versão:v1.2.0-Beta-2199-200eaa

---

## Configurações de Rede do PS2 (Network Settings)

Acesse o menu de configurações de rede do OPL (**Press START > Network Settings**) e configure:

### **- PS2 Network Settings -**
- **IP Address Type:** `Static`
- **IP Address:** `192.168.22.x`
- **Mask:** `255.255.22.0`
- **Gateway:** `192.168.22.1`
- **DNS Server:** `192.168.22.1` ou `0.0.0.0`

### **- SMB Server Settings -**
- **Address Type:** `IP`
- **Address:** `` *(IP Estático do NAS)*
- **Port:** `445` *(porta padrão tcp)*
- **Share:** `PS2` *(Nome do compartilhamento entre colchetes no smb.conf)*
- **User:** `` -> username definido
- **Password:** *(Senha cadastrada via smbpasswd no Linux)*

---

## Estrutura de Pastas Esperada no NAS

Para o OPL reconhecer os jogos, a pasta compartilhada (`/srv/samba/ps2`) deve seguir a estrutura padrão do sistema:

```text
/srv/samba/ps2/
├── CD/             # ISOs de jogos em formato CD (menores que 700MB)
├── DVD/            # ISOs de jogos em formato DVD padrão
├── VMC/            # Virtual Memory Cards (Saves de jogos)
└── ART/            # Capas e artes dos jogos

