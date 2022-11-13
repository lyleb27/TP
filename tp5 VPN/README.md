Serveur VPN

I. Setup machine distante

1. Utilisateurs :

➜ Création d'utilisateur
```
PS C:\Users\lebou> ssh rocky@44.204.64.99

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

Step 2 et 3 :

```
[rocky@ip-172-31-85-140 ~]$ sudo nano /etc/wireguard/wg0.conf
```
```
[Interface]
PrivateKey = KJjZHT...
Address = 10.8.0.1/24, fd0d:86fa:c3bc::1/64
ListenPort = 51820
SaveConfig = true
```

Step 4 — Adjusting the WireGuard Server’s Network Configuration :
```
[rocky@ip-172-31-85-140 ~]$ sudo nano /etc/sysctl.conf
```
```
# sysctl settings are defined through files in
# /usr/lib/sysctl.d/, /run/sysctl.d/, and /etc/sysctl.d/.
#
# Vendors settings live in /usr/lib/sysctl.d/.
# To override a whole file, create a new file with the same in
# /etc/sysctl.d/ and put new settings there. To override
# only specific settings, add a file with a lexically later
# name in /etc/sysctl.d/ and put new settings there.
#
# For more information, see sysctl.conf(5) and sysctl.d(5).
net.ipv4.ip_forward=1
```
```
[rocky@ip-172-31-85-140 ~]$ sudo sysctl -p
net.ipv4.ip_forward = 1
```

Step 6 — Starting the WireGuard Server :
```
[rocky@ip-172-31-85-140 ~]$ sudo systemctl enable wg-quick@wg0.service
Created symlink /etc/systemd/system/multi-user.target.wants/wg-quick@wg0.service → /usr/lib/systemd/system/wg-quick@.service.
```

```
[rocky@ip-172-31-85-140 ~]$ sudo systemctl status wg-quick@wg0.service
● wg-quick@wg0.service - WireGuard via wg-quick(8) for wg0
   Loaded: loaded (/usr/lib/systemd/system/wg-quick@.service; enabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Sat 2022-11-12 18:00:53 UTC; 1 day 3h ago
     Docs: man:wg-quick(8)
           man:wg(8)
           https://www.wireguard.com/
           https://www.wireguard.com/quickstart/
           https://git.zx2c4.com/wireguard-tools/about/src/man/wg-quick.8
           https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8
 Main PID: 33572 (code=exited, status=1/FAILURE)

Nov 12 18:00:53 ip-172-31-85-140.ec2.internal systemd[1]: Starting WireGuard via wg-quick(8) for wg0...
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal wg-quick[33572]: [#] ip link add wg0 type wireguard
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal wg-quick[33581]: Error: Unknown device type.
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal wg-quick[33584]: Unable to access interface: Protocol not supported
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal wg-quick[33572]: [#] ip link delete dev wg0
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal wg-quick[33586]: Cannot find device "wg0"
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal systemd[1]: wg-quick@wg0.service: Main process exited, code=exited, statu>
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal systemd[1]: wg-quick@wg0.service: Failed with result 'exit-code'.
Nov 12 18:00:53 ip-172-31-85-140.ec2.internal systemd[1]: Failed to start WireGuard via wg-quick(8) for wg0.
```

Step 7 — Configuring a WireGuard Peer :
```
[rocky@ip-172-31-85-140 ~]$ sudo dnf install elrepo-release epel-release
Complete!
```
```
[rocky@ip-172-31-85-140 ~]$ sudo dnf install kmod-wireguard wireguard-tools
Complete!
```
```
[rocky@ip-172-31-85-140 ~]$ wg genkey | sudo tee /etc/wireguard/private.key
mHm7...
```
```
[rocky@ip-172-31-85-140 ~]$ sudo cat /etc/wireguard/private.key | wg pubkey | sudo tee /etc/wireguard/public.key
3urO2GV/CSZn1FFTtsfaGk2G7MX+vq7NO4A+LQWl/XI=
```
```
[rocky@ip-172-31-85-140 ~]$ sudo nano /etc/wireguard/wg0.conf

[Interface]
PrivateKey = mHm7...
Address = 10.8.0.1/24, fd0d:86fa:c3bc::1/64
ListenPort = 51820
SaveConfig = true
[Peer]
PublicKey = 3urO2GV/CSZn1FFTtsfaGk2G7MX+vq7NO4A+LQWl/XI=
AllowedIPs = 10.8.0.0/24, fd0d:86fa:c3bc::/64
Endpoint = 203.0.113.1:5182
```

Step 8 — Adding the Peer’s Public Key to the WireGuard Server :
```
[rocky@ip-172-31-85-140 ~]$ sudo cat /etc/wireguard/public.key
3urO2GV/CSZn1FFTtsfaGk2G7MX+vq7NO4A+LQWl/XI=
```
```
[rocky@ip-172-31-85-140 ~]$ sudo wg set wg0 peer 3urO2GV/CSZn1FFTtsfaGk2G7MX+vq7NO4A+LQWl/XI= allowed-ips 10.8.0.1,fd0d:
86fa:c3bc::1
Unable to modify interface: Protocol not supported
```

Step 9 — Connecting the WireGuard Peer to the Tunnel :
```
[rocky@ip-172-31-85-140 ~]$ sudo wg-quick up wg0
[#] ip link add wg0 type wireguard
Error: Unknown device type.
Unable to access interface: Protocol not supported
[#] ip link delete dev wg0
Cannot find device "wg0"
```