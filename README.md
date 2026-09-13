<p align="center">
  <img src="https://github.com/user-attachments/assets/9b648b7f-2ce0-434a-98c2-f62435100ccc" alt="Stack Banner" width="100%">
</p>

# NAS-SMB HomeLab Configuration
![Debian](https://img.shields.io/badge/OS-Debian%2012-A81D24?style=flat&logo=debian&logoColor=white)
![Samba](https://img.shields.io/badge/Service-Samba%20SMB3-blue?style=flat)
![Tailscale](https://img.shields.io/badge/VPN-Tailscale-black?style=flat&logo=tailscale)

https://github.com/user-attachments/assets/84be0b59-a752-4b01-a5df-9ba2403ca0f7


![Architecture](https://img.shields.io/badge/Arch-32--bit%20x86-orange?style=flat)
> Configurações e topologia de rede para um servidor NAS/SMB caseiro de baixo custo, otimizado para alta taxa de transferência no PlayStation 2 (OPL) e armazenamento em nuvem privada.

---

<details open>
<summary><b>🇧🇷 Português (Clique para recolher)</b></summary>

<br>

### 📌 Sobre o Projeto

As configurações principais do meu **NAS HomeLab**. Construído a partir de um laptop de modelo antigo (**LGX130**) rodando **Samba Server (SMB3)**, o sistema cumpre duas funções estratégicas na rede:

1. **Servidor de Jogos para PS2 (OPL via SMB):** A escolha do protocolo SMB para o PlayStation 2 garante uma **taxa de transferência significativamente superior** à porta USB 1.1 nativa do console. Isso reduz o tempo de carregamento (*loading screens*) e elimina travamentos (*stuttering*) nas cutscenes dos jogos.
2. **Nuvem Privada:** Funciona como um armazenamento centralizado (estilo Google Drive) para compartilhamento seguro de arquivos com amigos.

<p align="center">
  <img src="https://github.com/user-attachments/assets/670193b0-41e5-4e0b-a21d-fda1eab71c21" alt="Simulação de Conectividade Packet Tracer" width="700">
</p>

> **Nota:** Os endereços IP exibidos nas demonstrações são meramente ilustrativos. Para verificar o fluxo completo da rede em execução, abra o arquivo `.pkt` no software **Cisco Packet Tracer**.

<p align="center">
  <img src="https://github.com/user-attachments/assets/0ab4b02d-f3ae-4b25-a049-02e3048cfdaa" alt="Topologia da Rede" width="700">
</p>

---

### Arquitetura da Rede

- **Rede Cabeada (LAN Principal):** Servidor Samba no Linux Debian + Switch de Distribuição (link dedicado para o PS2 via Ethernet para máxima largura de banda).
- **Rede Wireless (WLAN):** Roteador Wi-Fi gerenciando clientes móveis (Smartphones/Laptops) com suporte a WireGuard via Tailscale.
- **Roteamento & Serviços:** Comunicação inter-redes com atribuição dinâmica via DHCP e testes de conectividade ICMP de ponta a ponta.

---

### Tecnologias Utilizadas

- **Cisco Packet Tracer:** Modelagem e simulação da topologia de rede.
- **Linux Debian 12 (32-bits):** Sistema operacional de base otimizado para o hardware do servidor.
- **Samba (SMB/CIFS):** Compartilhamento de arquivos em rede de alta velocidade ajustado para a stack de rede do OPL/PS2.
- **Tailscale / WireGuard:** Acesso remoto seguro à rede do HomeLab.

<br>

### Exemplo de tabela de Endereçamento

| Dispositivo | Interface | Endereço IP / Máscara | Função |
| :--- | :--- | :--- | :--- |
| **Debian Server** | xx | `192.168.22.10/24` | Servidor Samba (SMB3) |
| **PS2 (OPL)** | Ethernet | `192.168.22.15/24` | Cliente de Jogos via Rede |
| **Roteador Wi-Fi** | LAN/WLAN | `192.168.22.1/24` | Gateway & Servidor DHCP |
| **Clientes Wi-Fi** | Wireless | DHCP (`192.168.22.50-100`) | Acesso Geral / Celulares |

---

### Configuração Rápida do Samba (`/etc/samba/smb.conf`)

Exemplo do bloco de compartilhamento configurado para o OPL no Debian:

```ini
[global]
   workgroup = WORKGROUP
   server string = HomeLab NAS Server
   security = user

   # Compatibilidade de Protocolo e Autenticação com OPL (PS2)
   server max protocol = SMB3
   server min protocol = NT1
   lanman auth = yes
   ntlm auth = yes
   raw NTLMv2 auth = yes
   server signing = disabled
   smb ports = 445 139

[PS2SMB]
   comment = Apenas compartilhamento de jogos para o OPL (leitura, somente)
   path = /srv/samba/ps2
   browsable = yes
   guest ok = yes
   public = yes
   read only = no
   valid users = ps2username
```
<p align="center">
  <img src="https://github.com/user-attachments/assets/a67b0341-4c7e-4af1-b2ec-e319e7723354" alt="Hardware do Servidor" width="45%">
  &nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/9aa03e3d-7bfc-42b6-bc99-6442ca42916c" alt="Configuração do Sistema" width="45%">
</p>

</details>

---
---

### Referências & Documentação para consulta 

- **Debian Linux:** [Documentação Oficial do Debian 12 (Bookworm)](https://www.debian.org/doc/)
- **Samba Project:** [Samba smb.conf Official Documentation](https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html)
- **Open PS2 Loader (OPL):** [OPL Official SMB Guide & Network Setup](https://ps2home.gitbook.io/official-display-item-documentation/guides/open-ps2-loader)
- **Cisco Networking:** [Cisco Packet Tracer User Guide](https://www.netacad.com/courses/packet-tracer)
- **Tailscale:** [Tailscale WireGuard Documentation](https://tailscale.com/kb/)
<details>

  
<summary><b>🇺🇸 English (Click to expand)</b></summary>

<br>

### 📌 About the Project

The core configurations of my **NAS HomeLab**. Built from an older model laptop (**LGX130**) running **Samba Server (SMB3)**, the system fulfills two main roles:

1. **PS2 Game Server (OPL via SMB):** Utilizing the SMB protocol for the PlayStation 2 delivers a **significantly higher data transfer rate** compared to the console's native USB 1.1 interface. This minimizes loading times and eliminates video FMV stuttering during gameplay.
2. **Private Cloud Storage:** Acts as a centralized network storage (Google Drive alternative) for seamless file sharing with friends.

<p align="center">
  <img src="https://github.com/user-attachments/assets/670193b0-41e5-4e0b-a21d-fda1eab71c21" alt="Packet Tracer Simulation Demo" width="700">
</p>

> **Note:** The IP addresses shown in the demonstrations are for illustrative purposes only. For full network simulation details, open the `.pkt` file using **Cisco Packet Tracer**.

<p align="center">
  <img src="https://github.com/user-attachments/assets/0ab4b02d-f3ae-4b25-a049-02e3048cfdaa" alt="Network Topology" width="700">
</p>

---

### Network Architecture

- **Wired Network (Main LAN):** Samba Server on Linux Debian + Distribution Switch (dedicated Ethernet link for PS2 to maximize throughput).
- **Wireless Network (WLAN):** Wi-Fi Router managing mobile clients (Smartphones/Laptops) with WireGuard support via Tailscale.
- **Routing & Services:** Inter-network communication via DHCP assignment and end-to-end ICMP connectivity testing.

---

### Technologies Used

- **Cisco Packet Tracer:** Network topology modeling and simulation.
- **Linux Debian 12 (32-bit):** Base operating system optimized for legacy hardware.
- **Samba (SMB/CIFS):** High-speed network file sharing fine-tuned for OPL/PS2 network stack.
- **Tailscale / WireGuard:** Secure remote access to the HomeLab network.

<br>

| Device | Interface | IP Address | Function |
| :--- | :--- | :--- | :--- |
| **Debian Server** | xx | `192.168.22.10/24` | Samba Server (SMB3) |
| **PS2 (OPL)** | Ethernet | `192.168.22.15/24` | Game Client for games |
| **Roteador Wi-Fi** | LAN/WLAN | `192.168.22.1/24` | Gateway & DHCP Server |
| **Clientes Wi-Fi** | Wireless | DHCP (`192.168.22.50-100`) | General Acess/cellphone/laptops |


<br>

### Configuração Rápida do Samba (`/etc/samba/smb.conf`)

An example of basic Samba Config to OPL:

```ini
[global]
   workgroup = WORKGROUP
   server string = HomeLab NAS Server
   security = user

   # Protocol Compatibility and Authentication with OPL (PS2)
   server max protocol = SMB3
   server min protocol = NT1
   lanman auth = yes
   ntlm auth = yes
   raw NTLMv2 auth = yes
   server signing = disabled
   smb ports = 445 139

[PS2SMB]
   comment = only to share games during Network traffic 
   path = /srv/samba/ps2
   browsable = yes
   guest ok = yes
   public = yes
   read only = no
   valid users = ps2username
```

<br>

<p align="center">
  <img src="https://github.com/user-attachments/assets/a67b0341-4c7e-4af1-b2ec-e319e7723354" alt="Server Hardware" width="45%">
  &nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/9aa03e3d-7bfc-42b6-bc99-6442ca42916c" alt="System Configuration" width="45%">
</p>

---

### References & Documentation

- **Debian Linux:** [Debian 12 (Bookworm) Official Documentation](https://www.debian.org/doc/)
- **Samba Project:** [Samba smb.conf Official Manual](https://www.samba.org/samba/docs/current/man-html/smb.conf.5.html)
- **Open PS2 Loader (OPL):** [OPL Official SMB Setup Guide](https://ps2home.gitbook.io/official-display-item-documentation/guides/open-ps2-loader)
- **Cisco Networking:** [Cisco Packet Tracer Documentation](https://www.netacad.com/courses/packet-tracer)
- **Tailscale:** [Tailscale WireGuard Setup Guide](https://tailscale.com/kb/)

</details>
