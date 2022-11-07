Serveur VPN

I. Setup machine distante

1. Utilisateurs :

➜ Création d'utilisateur
```
PS C:\Users\lebou> ssh rocky@44.204.64.99
The authenticity of host '44.204.64.99 (44.204.64.99)' can't be established.
ECDSA key fingerprint is SHA256:I3Gz3AiSx1AAzLqpRjXAdZKTpujY7GoRqctXUyz9JJo.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '44.204.64.99' (ECDSA) to the list of known hosts.
Activate the web console with: systemctl enable --now cockpit.socket

[rocky@ip-172-31-85-140 ~]$
```

2. Serveur SSH :

A. Connexion par clé

➜ Génération d'une paire de clé SUR LE CLIENT
```
PS C:\Users\lebou> ssh-keygen -t rsa -b 4096
Generating public/private rsa key pair.
```
➜ Assurez-vous d'avoir une connexion sans mot de passe à la machine
```
PS C:\Users\lebou> ssh rocky@44.204.64.99
Activate the web console with: systemctl enable --now cockpit.socket

Last login: Mon Nov  7 14:35:19 2022 from 77.196.149.138
[rocky@ip-172-31-85-140 ~]$
```
B. SSH Server Hardening
```
[rocky@ip-172-31-85-140 ~]$ sudo nano /etc/ssh/sshd_config
```

II. Serveur VPN

Step 1 — Installing WireGuard and Generating a Key Pair :
```
[rocky@ip-172-31-85-140 ~]$ sudo dnf install elrepo-release epel-release
Complete!
[rocky@ip-172-31-85-140 ~]$ sudo dnf install kmod-wireguard wireguard-tools
Complete!
```
```
[rocky@ip-172-31-85-140 ~]$ wg genkey | sudo tee /etc/wireguard/private.key
KJjZHT...
[rocky@ip-172-31-85-140 ~]$ sudo chmod go= /etc/wireguard/private.key
[rocky@ip-172-31-85-140 ~]$ sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
Mthevp3pm9/8NfdCVWdjA/OerH3oTQtNddeM9FAYAmg=
```
Step 2 — Choosing IPv4 :

```

```