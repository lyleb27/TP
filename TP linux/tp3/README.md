TP 3 : We do a little scripting

I. Script carte d'identité

- Le script :
```
[it4@tp3 idcard]$ bash idcard.sh
echo "Machine name : $(hostnamectl --static)"
echo "OS $(cat /etc/redhat-release) and kernel version is $(uname)"
echo "IP : $(ip a | grep "inet " | tail -n1 | tr -s ' ' | cut -d ' ' -f3)"
echo "RAM : $(free -h --mega | grep Mem: | tr -s ' ' | cut -d' ' -f7) memory available on $(free -h --mega | grep Mem: | tr -s ' ' | cut -d' ' -f2) total >echo "Disk : $(df -H -a | grep " /$" | tr -s ' ' | cut -d' ' -f4) space left"
echo "Top 5 processes by RAM usage :"
a="$(ps -e -o %mem=,cmd= --sort=-%mem  | head -n5)"
while read processes
do
echo - $processes
done <<< "${a}"
z="$(ss -ltn4H | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f2)"
echo "Listening ports :"
while read tcp
do
echo - $tcp tcp : sshd
done <<<"${z}"
y="$(ss -lun4H | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f2)"
while read udp
do
echo  - $udp udp : sshd
done <<<"${y}"


echo "Here is your random cat : ./cat.jpg"
```

[📁 Fichier /srv/idcard/idcard.sh](idcard.sh)

II. Script youtube-dl 

➜ 1. Permettre le téléchargement d'une vidéo youtube dont l'URL est passée au script

🌞 Vous fournirez dans le compte-rendu, en plus du fichier, un exemple d'exécution avec une sortie, dans des balises de code :
```
[it4@tp3 yt]$ ./yt.sh https://www.youtube.com/watch?v=jhFDyDgMVUI
Video https://www.youtube.com/watch?v=jhFDyDgMVUI was downloaded
File path : /srv/yt/downloads/One Second Video/One Second Video.mp4
```
[📁 Le script /srv/yt/yt.sh](yt.sh)

[📁 Le fichier de log /var/log/yt/download.log](download.log)

III. MAKE IT A SERVICE

🌞 Vous fournirez dans le compte-rendu, en plus des fichiers :
- un systemctl status yt quand le service est en cours de fonctionnement
```

```
- un extrait de journalctl -xe -u yt
- ```

```
📁 Le script /srv/yt/yt-v2.sh
📁 Fichier /etc/systemd/system/yt.service
