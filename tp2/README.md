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
Adresse de réseau : 192.168.136.0

Adresse de broadcast : 192.168.139.255


🌞 Prouvez que la connexion est fonctionnelle entre les deux machines :
```

```


🌞 Wireshark it :


Déterminez, grâce à Wireshark, quel type de paquet ICMP est envoyé par ping :



🦈 PCAP qui contient les paquets ICMP qui vous ont permis d'identifier les types ICMP :



II. ARP my bro :

🌞 Check the ARP table :



🌞 Manipuler la table ARP :



🌞 Wireshark it :



🦈 PCAP qui contient les trames ARP :

