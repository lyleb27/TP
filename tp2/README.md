TP2 : Ethernet, IP, et ARP


I. Setup IP

🌞 Mettez en place une configuration réseau fonctionnelle entre les deux machines :
```
PS C:\WINDOWS\system32> netsh interface ipv4 set address name="Ethernet" static 192.168.137.2 255.255.252.0 192.168.137.1

Carte Ethernet Ethernet :
   Adresse IPv4. . . . . . . . . . . . . .: 192.168.137.2(préféré)
   Masque de sous-réseau. . . . . . . . . : 255.255.252.0
   Passerelle par défaut. . . . . . . . . : 192.168.137.1
```


🌞 Prouvez que la connexion est fonctionnelle entre les deux machines :
```
PS C:\Users\lebou> ping 192.168.137.1

Envoi d’une requête 'Ping'  192.168.137.1 avec 32 octets de données :
Réponse de 192.168.137.1 : octets=32 temps=2 ms TTL=128
Réponse de 192.168.137.1 : octets=32 temps=2 ms TTL=128
Réponse de 192.168.137.1 : octets=32 temps=2 ms TTL=128
Réponse de 192.168.137.1 : octets=32 temps=3 ms TTL=128

Statistiques Ping pour 192.168.137.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 2ms, Maximum = 3ms, Moyenne = 2ms
```


🌞 Wireshark it :


Déterminez, grâce à Wireshark, quel type de paquet ICMP est envoyé par ping :



🦈 PCAP qui contient les paquets ICMP qui vous ont permis d'identifier les types ICMP :



II. ARP my bro :

🌞 Check the ARP table :



🌞 Manipuler la table ARP :



🌞 Wireshark it :



🦈 PCAP qui contient les trames ARP :

