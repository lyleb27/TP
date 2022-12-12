TP 3 : We do a little scripting

I. Script carte d'identité

➜ Ce que doit faire le script. Il doit afficher :

- Le nom de la machine :
```
[it4@tp3 idcard]$ hostnamectl --static
tp3.linux
```

- Le nom de l'OS de la machine :
```
[it4@tp3 idcard]$ [it4@tp3 idcard]$ cat /etc/redhat-release
Rocky Linux release 9.0 (Blue Onyx)
```

- La version du noyau Linux utilisé par la machine :
```
[it4@tp3 idcard]$ uname
Linux
```
- L'adresse IP de la machine :
```
[it4@tp3 idcard]$ ip a | grep "inet " | tail -n1 | tr -s ' ' | cut -d ' ' -f3
10.2.3.3/24
```

- L'état de la RAM :
Espace dispo. :
```
[it4@tp3 idcard]$ free -h --mega | grep Mem: | tr -s ' ' | cut -d' ' -f7
653M
```
Taille totale de la RAM :
```
[it4@tp3 idcard]$ free -h --mega | grep Mem: | tr -s ' ' | cut -d' ' -f2
960M
```

- L'espace restant sur le disque dur, en Go (ou Mo, ou ko) :
```
[it4@tp3 idcard]$ df -H -a | grep " /$" | tr -s ' ' | cut -d' ' -f4
5.5G
```

- Le top 5 des processus qui pompent le plus de RAM sur la machine actuellement : 
```
a="$(ps -e -o %mem=,cmd= --sort=-%mem  | head -n5)"
while read processes
do
echo - $processes
done <<< "${a}"
```

- La liste des ports en écoute sur la machine, avec le programme qui est derrière :
```
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
```

- Un lien vers une image/gif random de chat :
```
[it4@tp3 idcard]$ curl https://cataas.com/cat --output cat
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0Warning: Failed to create the file cat: Permission denied
 49 32223   49 16052    0     0  35356      0 --:--:-- --:--:-- --:--:-- 35356
curl: (23) Failure writing output to destination
[it4@tp3 idcard]$ file cat
cat: JPEG image data, JFIF standard 1.01, resolution (DPI), density 72x72, segment length 16, baseline, precision 8, 600x802, components 3
```

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

II. Script youtube-dl 

➜ 1. Permettre le téléchargement d'une vidéo youtube dont l'URL est passée au script

- La vidéo devra être téléchargée dans le dossier /srv/yt/downloads/ :
```

```

- Plus précisément, chaque téléchargement de vidéo créera un dossier :
```

```

