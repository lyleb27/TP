I. ARP
```
[it4@localhost ~]$ cat /etc/sysconfig/network-scripts/ifcfg-enp0s8
DEVICE=enp0s8

BOOTPROTO=static
ONBOOT=yes

IPADDR=10.3.1.12
NETMASK=255.255.255.0

[it4@localhost ~]$ sudo systemctl restart NetworkManager

[it4@localhost ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:78:b4:21 brd ff:ff:ff:ff:ff:ff
    inet 10.3.1.12/24 brd 10.3.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe78:b421/64 scope link
       valid_lft forever preferred_lft forever
```
1. Echange ARP
🌞Générer des requêtes ARP :
```
PS C:\Users\lebou> ping 10.3.1.11

Envoi d’une requête 'Ping'  10.3.1.11 avec 32 octets de données :
Réponse de 10.3.1.11 : octets=32 temps<1ms TTL=64
Réponse de 10.3.1.11 : octets=32 temps<1ms TTL=64
Réponse de 10.3.1.11 : octets=32 temps<1ms TTL=64

Statistiques Ping pour 10.3.1.11:
    Paquets : envoyés = 3, reçus = 3, perdus = 0 (perte 0%),
Durée approximative des boucles en millisecondes :
    Minimum = 0ms, Maximum = 0ms, Moyenne = 0ms
Ctrl+C
```
```
[it4@localhost ~]$ ip neigh show
10.3.1.12 dev enp0s8 lladdr 08:00:27:78:b4:21 STALE
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:43 REACHABLE
```
MAC de Marcel : "08:00:27:78:b4:21"
```
[it4@localhost ~]$ ip neigh show
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:43 DELAY
10.3.1.11 dev enp0s8 lladdr 08:00:27:ac:f5:dc STALE
```
MAC de John : "08:00:27:ac:f5:dc"

```
[it4@localhost ~]$ ip neigh show 10.3.1.12
10.3.1.12 dev enp0s8 lladdr 08:00:27:78:b4:21 STALE
```
```
[it4@localhost ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:78:b4:21 brd ff:ff:ff:ff:ff:ff
    inet 10.3.1.12/24 brd 10.3.1.255 scope global noprefixroute enp0s8
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe78:b421/64 scope link
       valid_lft forever preferred_lft forever
```
2. Analyse de trames
🌞Analyse de trames : 
```
[it4@localhost ~]$ sudo ip neigh flush all
```
```
[it4@localhost ~]$ ping 10.3.1.11
PING 10.3.1.11 (10.3.1.11) 56(84) bytes of data.
64 bytes from 10.3.1.11: icmp_seq=1 ttl=64 time=0.451 ms
64 bytes from 10.3.1.11: icmp_seq=2 ttl=64 time=1.06 ms
64 bytes from 10.3.1.11: icmp_seq=3 ttl=64 time=0.986 ms
64 bytes from 10.3.1.11: icmp_seq=4 ttl=64 time=1.05 ms
64 bytes from 10.3.1.11: icmp_seq=5 ttl=64 time=1.01 ms
64 bytes from 10.3.1.11: icmp_seq=6 ttl=64 time=0.905 ms
64 bytes from 10.3.1.11: icmp_seq=7 ttl=64 time=0.991 ms
64 bytes from 10.3.1.11: icmp_seq=8 ttl=64 time=0.971 ms
64 bytes from 10.3.1.11: icmp_seq=9 ttl=64 time=0.968 ms
64 bytes from 10.3.1.11: icmp_seq=10 ttl=64 time=0.985 ms
64 bytes from 10.3.1.11: icmp_seq=11 ttl=64 time=0.469 ms
^C
--- 10.3.1.11 ping statistics ---
11 packets transmitted, 11 received, 0% packet loss, time 10020ms
rtt min/avg/max/mdev = 0.451/0.895/1.061/0.209 ms
```
```
PS C:\Users\lebou> scp it4@10.3.1.11:/home/it4/tp3_arp.pcapng ./
it4@10.3.1.11's password:
tp3_arp.pcapng                                                                        100%  976   488.3KB/s   00:00
```
🦈 [Capture réseau tp3_arp.pcapng qui contient un ARP request et un ARP reply](./tp3_arp.pcapng)

II. Routage
1. Mise en place du routage
🌞Activer le routage sur le noeud router :
```
[it4@localhost ~]$ sudo firewall-cmd --list-all

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for it4:
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: enp0s8 enp0s9
  sources:
  services: cockpit dhcpv6-client ssh
  ports:
  protocols:
  forward: yes
  masquerade: yes
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:
[it4@localhost ~]$ sudo firewall-cmd --get-active-zone
public
  interfaces: enp0s8 enp0s9
[it4@localhost ~]$ sudo firewall-cmd --add-masquerade --zone=public
success
[it4@localhost ~]$ sudo firewall-cmd --add-masquerade --zone=public --permanent
success
```

🌞Ajouter les routes statiques nécessaires pour que john et marcel puissent se ping :
- John :
```
[it4@localhost ~]$ ip r s
10.3.1.0/24 dev enp0s8 proto kernel scope link src 10.3.1.11 metric 100
10.3.2.0/24 via 10.3.1.254 dev enp0s8
```
- Marcel :
```
[it4@localhost ~]$ ip r s
10.3.1.0/24 via 10.3.2.254 dev enp0s8
10.3.2.0/24 dev enp0s8 proto kernel scope link src 10.3.2.12 metric 100
```
```
[it4@localhost ~]$ ping 10.3.2.12
PING 10.3.2.12 (10.3.2.12) 56(84) bytes of data.
64 bytes from 10.3.2.12: icmp_seq=1 ttl=63 time=0.927 ms
64 bytes from 10.3.2.12: icmp_seq=2 ttl=63 time=1.97 ms
64 bytes from 10.3.2.12: icmp_seq=3 ttl=63 time=2.09 ms
64 bytes from 10.3.2.12: icmp_seq=4 ttl=63 time=1.04 ms
64 bytes from 10.3.2.12: icmp_seq=5 ttl=63 time=1.91 ms
64 bytes from 10.3.2.12: icmp_seq=6 ttl=63 time=1.90 ms
64 bytes from 10.3.2.12: icmp_seq=7 ttl=63 time=1.93 ms
64 bytes from 10.3.2.12: icmp_seq=8 ttl=63 time=2.03 ms
64 bytes from 10.3.2.12: icmp_seq=9 ttl=63 time=0.881 ms
64 bytes from 10.3.2.12: icmp_seq=10 ttl=63 time=1.88 ms
64 bytes from 10.3.2.12: icmp_seq=11 ttl=63 time=1.99 ms
^C
--- 10.3.2.12 ping statistics ---
11 packets transmitted, 11 received, 0% packet loss, time 10033ms
rtt min/avg/max/mdev = 0.881/1.685/2.092/0.456 ms
```

2. Analyse de trames

🌞Analyse des échanges ARP :
```
[it4@localhost ~]$ sudo ip neigh flush all
```
```
[it4@localhost ~]$ ping 10.3.2.12
PING 10.3.2.12 (10.3.2.12) 56(84) bytes of data.
64 bytes from 10.3.2.12: icmp_seq=1 ttl=63 time=1.82 ms
64 bytes from 10.3.2.12: icmp_seq=2 ttl=63 time=1.09 ms
64 bytes from 10.3.2.12: icmp_seq=3 ttl=63 time=0.892 ms
64 bytes from 10.3.2.12: icmp_seq=4 ttl=63 time=1.88 ms
^C
--- 10.3.2.12 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3065ms
rtt min/avg/max/mdev = 0.892/1.422/1.882/0.435 ms
```
Regardez les tables ARP des trois noeuds :
- John :
```
[it4@localhost ~]$ ip neigh show
10.3.1.254 dev enp0s8 lladdr 08:00:27:9e:78:e1 STALE
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:0e DELAY
```
- Marcel :
```
[it4@localhost ~]$ ip neigh show
10.3.2.1 dev enp0s8 lladdr 0a:00:27:00:00:12 DELAY
10.3.2.254 dev enp0s8 lladdr 08:00:27:1e:1b:c2 STALE
```
- Router :
```
[it4@localhost ~]$ ip neigh show
10.3.1.11 dev enp0s8 lladdr 08:00:27:ac:f5:dc STALE
10.3.2.12 dev enp0s9 lladdr 08:00:27:78:b4:21 STALE
10.3.1.1 dev enp0s8 lladdr 0a:00:27:00:00:0e DELAY
```

```
| ordre | type trame  | IP source | MAC source                   | IP destination | MAC destination                 |
|-------|-------------|-----------|------------------------------|----------------|---------------------------------|
| 1     | Requête ARP | x         | `marcel` `08:00:27:1e:1b:c2` | x              | Broadcast `FF:FF:FF:FF:FF`      |
| 2     | Réponse ARP | x         | `jhon` `08:00:27:78:b4:21`   | x              | `marcel` `08:00:27:1e:1b:c2`    |
| ...   | ...         | ...       | ...                          | ...            | ...                             |
| 4     | Ping        | 10.3.2.254| `marcel` `08:00:27:1e:1b:c2` | 10.3.2.12      | jhon` `08:00:27:78:b4:21`       |
| 5     | Pong        | 10.3.2.12 | jhon` `08:00:27:78:b4:21`    | 10.3.2.254     | `marcel` `08:00:27:1e:1b:c2`    |
```
🦈 [Capture réseau tp3_routage_marcel.pcapng](tp3_routage_marcel.pcapng)