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
PS C:\WINDOWS\system32> ping 192.168.137.1

Envoi d’une requête 'Ping'  192.168.137.1 avec 32 octets de données :
Réponse de 192.168.137.1 : octets=32 temps=1 ms TTL=64
Réponse de 192.168.137.1 : octets=32 temps=2 ms TTL=64
Réponse de 192.168.137.1 : octets=32 temps=2 ms TTL=64
Réponse de 192.168.137.1 : octets=32 temps=1 ms TTL=64

Statistiques Ping pour 192.168.137.1:
    Paquets : envoyés = 4, reçus = 4, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 1ms, Maximum = 2ms, Moyenne = 1ms
```


🌞 Wireshark it :

Déterminez, grâce à Wireshark, quel type de paquet ICMP est envoyé par ping :

Reply : type 0.

Request : type 8.


🦈 [PCAP qui contient les paquets ICMP qui vous ont permis d'identifier les types ICMP](Ping%20icmp.pcapng)



II. ARP my bro :

🌞 Check the ARP table :
```
PS C:\WINDOWS\system32> arp -A

Interface : 192.168.137.2 --- 0x2
  Adresse Internet      Adresse physique      Type
  192.168.137.1         00-e0-4c-68-00-33     dynamique

Interface : 10.33.16.190 --- 0x13
  Adresse Internet      Adresse physique      Type
  10.33.19.254          00-c0-e7-e0-04-4e     dynamique
```


🌞 Manipuler la table ARP :
```
PS C:\WINDOWS\system32> arp -d
PS C:\WINDOWS\system32> arp -A

Interface : 192.168.137.2 --- 0x2
  Adresse Internet      Adresse physique      Type
  224.0.0.22            01-00-5e-00-00-16     statique

Interface : 192.168.75.1 --- 0x11
  Adresse Internet      Adresse physique      Type
  224.0.0.22            01-00-5e-00-00-16     statique

Interface : 10.33.16.190 --- 0x13
  Adresse Internet      Adresse physique      Type
  10.33.19.254          00-c0-e7-e0-04-4e     dynamique
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique

Interface : 192.168.124.1 --- 0x17
  Adresse Internet      Adresse physique      Type
  224.0.0.22            01-00-5e-00-00-16     statique
```
```
PS C:\WINDOWS\system32> ping 192.168.137.1
PS C:\WINDOWS\system32> arp -A

Interface : 192.168.137.2 --- 0x2
  Adresse Internet      Adresse physique      Type
  192.168.137.1         00-e0-4c-68-00-33     dynamique
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique

Interface : 192.168.75.1 --- 0x11
  Adresse Internet      Adresse physique      Type
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique

Interface : 10.33.16.190 --- 0x13
  Adresse Internet      Adresse physique      Type
  10.33.19.254          00-c0-e7-e0-04-4e     dynamique
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique

Interface : 192.168.124.1 --- 0x17
  Adresse Internet      Adresse physique      Type
  224.0.0.2             01-00-5e-00-00-02     statique
  224.0.0.22            01-00-5e-00-00-16     statique
```


🌞 Wireshark it :

 Mettez en évidence les deux trames ARP échangées lorsque vous essayez de contacter quelqu'un pour la "première" fois :

      - Déterminez, pour les deux trames, les adresses source et destination :
- ARP Request :
```
Src: RealtekS_68:00:33 (00:e0:4c:68:00:33), Dst: HP_59:ae:90 (00:68:eb:59:ae:90)
```
- ARP Reply :
```
Src: HP_59:ae:90 (00:68:eb:59:ae:90), Dst: RealtekS_68:00:33 (00:e0:4c:68:00:33)
```
Chacune de ces adresses correspond à l'addresse MAC qui est associé à l'IP qui lui est propre. 

(00:e0:4c:68:00:33) = MAC de l'IP de la passerelle.

(00:68:eb:59:ae:90) = MAC de mon addresse IP.

🦈 [PCAP qui contient les trames ARP](./Ping%20arp.pcapng)



III. DHCP you too my brooo

🌞 Wireshark it

Mettez en évidence les adresses source et destination de chaque trame :

- DHCP Discover :
```
 Src: Chongqin_62:db:dd (40:23:43:62:db:dd), Dst: Broadcast (ff:ff:ff:ff:ff:ff)
```
- DHCP Offer :
```
Src: Fiberdat_e0:04:4e (00:c0:e7:e0:04:4e), Dst: Chongqin_62:db:dd (40:23:43:62:db:dd)
```
- DHCP Request :
```
Src: Chongqin_62:db:dd (40:23:43:62:db:dd), Dst: Broadcast (ff:ff:ff:ff:ff:ff)
```
- DHCP ACK : 
```
Src: Fiberdat_e0:04:4e (00:c0:e7:e0:04:4e), Dst: Chongqin_62:db:dd (40:23:43:62:db:dd)
```

Identifiez dans ces 4 trames les informations 1, 2 et 3 dont on a parlé juste au dessus :

- 1 :
```
10.33.16.190
```

- 2 :
```
10.33.19.254
```

- 3 :
```
 8.8.8.8
 8.8.4.4
 1.1.1.1
```

🦈 [PCAP qui contient l'échange DORA](DORA.pcapng)



