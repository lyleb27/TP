TP4 : TCP, UDP et services réseau

I. First steps

🌞 Déterminez, pour ces 5 applications, si c'est du TCP ou de l'UDP :

- Epic Games Launcher (TCP) :
IP dst : 18.233.248.142
Port dst : 443
Port src : 50486
🦈 [captures Wireshark (EGL)](Epic%20Games%20Launcher.pcapng)
netstat :
```
  TCP    10.33.16.190:50486     18.233.248.142:443      ESTABLISHED
  [EpicGamesLauncher.exe]
```

- Microsoft Solitaire Collection (TCP) :
IP dst : 20.123.104.105
Port dst : 443
Port src : 52766
🦈 [captures Wireshark (MSC)](Microsoft%20solitaire%20collection.pcapng)
netstat :
```
  TCP    10.33.16.190:52766     20.123.104.105:443       ESTABLISHED
  [Solitaire.exe]
```

- Teams (TCP) :
IP dst : 13.69.239.73
Port dst : 443
Port src : 56667
🦈 [captures Wireshark (T)](Teams.pcapng)
netstat :
```
 TCP    10.33.16.190:56667     13.69.239.73:443     ESTABLISHED
 [Teams.exe]
```

- Fortnite (UDP) :
IP dst : 18.168.46.105
Port dst : 15015
Port src : 57862
🦈 [captures Wireshark (F)](Fortnite(udp).pcapng)
netstat :
```
[System]
  UDP    0.0.0.0:57862          *:*
 [System]
  UDP    0.0.0.0:57861          *:*
```

- VIsual Studio Code (TCP) :
IP dst : 40.127.240.158
Port dst : 443
Port src : 50802
🦈 [captures Wireshark (VSC)](VS%20Code.pcapng)
netstat :
```
TCP    10.33.16.190:50802     40.127.240.158:443     CLOSE_WAIT
 [Code.exe]
```

II. Mise en place

1. SSH

🌞 Examinez le trafic dans Wireshark :


- Déterminez si SSH utilise TCP ou UDP :
SSH utilise TCP : [SSH](SSH%20(TCP).pcapng).

- Repérez le 3-Way Handshake à l'établissement de la connexion, du trafic SSH et le FIN ACK à la fin d'une connexion :
[3-Way Handshake](3-Way%20Handshake.pcapng).

🌞 Demandez aux OS :
- Depuis votre machine :
```
TCP    10.4.1.1:57376         10.4.1.11:22           ESTABLISHED
 [ssh.exe]
```
- Depuis votre VM :
```
tcp      ESTAB     0          52                               10.4.1.11:ssh               10.4.1.1:57401
```

III. DNS

1. Setup

🌞 Dans le rendu, je veux :


🌞 Ouvrez le bon port dans le firewall :


1. Test
🌞 Sur la machine node1.tp4.b1 :


🌞 Sur votre PC :
