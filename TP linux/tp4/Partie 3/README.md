Partie 3 : Serveur web :

2. Install :

🌞 Installez NGINX :
```
[it4@web ~]$ sudo dnf install nginx
Complete!
```

3. Analyse :

🌞 Analysez le service NGINX :
```
[it4@web ~]$ sudo ps -ef | grep nginx
root       11460       1  0 16:34 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx      11461   11460  0 16:34 ?        00:00:00 nginx: worker process
it4        11467     873  0 16:35 pts/0    00:00:00 grep --color=auto nginx
```
```
[it4@web ~]$ sudo ss -alnpt | grep nginx
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=11461,fd=6),("nginx",pid=11460,fd=6))
LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=11461,fd=7),("nginx",pid=11460,fd=7))
```
```
[it4@web ~]$ sudo cat /etc/nginx/nginx.conf | grep '^ *server {' -A 12 | grep include
        include /etc/nginx/default.d/*.conf;

[it4@web ~]$ ls -al /etc/nginx/default.d/
total 4
drwxr-xr-x. 2 root root    6 Oct 31 16:37 .
drwxr-xr-x. 4 root root 4096 Jan 16 16:34 ..
```

4. Visite du service web :

🌞 Configurez le firewall pour autoriser le trafic vers le service NGINX :
```
[it4@web ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[it4@web ~]$ sudo firewall-cmd --reload
success
```

🌞 Accéder au site web :
```
[it4@web ~]$ curl 10.2.3.8 | head -3       
<!doctype html>
<html>
  <head>
```

🌞 Vérifier les logs d'accès :
```
[it4@web ~]$ sudo cat /var/log/nginx/access.log | tail -3
10.2.3.8 - - [16/Jan/2023:17:00:21 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
10.2.3.8 - - [16/Jan/2023:17:00:27 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
10.2.3.8 - - [16/Jan/2023:17:00:35 +0100] "GET / HTTP/1.1" 200 7620 "-" "curl/7.76.1" "-"
```

5. Modif de la conf du serveur web :

🌞 Changer le port d'écoute :
```
[it4@web ~]$ cat /etc/nginx/nginx.conf | grep listen | head -1
        listen       8080;
```
```
[it4@web ~]$ ss -alnpt | grep 8080 | head -1
LISTEN 0      511          0.0.0.0:8080      0.0.0.0:*
```
```
[it4@web ~]$ sudo firewall-cmd --add-port=8080/tcp --permanent
success
[it4@web ~]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
[it4@web ~]$ sudo firewall-cmd --reload
success
```
```
[it4@web ~]$ curl http://10.2.3.8:8080 | head -3
<!doctype html>
<html>
  <head>
```

🌞 Changer l'utilisateur qui lance le service :
```

```

🌞 Changer l'emplacement de la racine Web :
```

```

6. Deux sites web sur un seul serveur :

🌞 Repérez dans le fichier de conf :
```

```

🌞 Créez le fichier de configuration pour le premier site :
```

```

🌞 Créez le fichier de configuration pour le deuxième site :
```

```

🌞 Prouvez que les deux sites sont disponibles :
```

```