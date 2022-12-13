TP2 : Appréhender l'environnement Linux

1. Analyse du service

🌞 S'assurer que le service sshd est démarré :
```
[it4@localhost ~]$ systemctl status sshd
● sshd.service - OpenSSH server daemon
     Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
     Active: active (running) since Tue 2022-11-22 16:45:06 CET; 15min ago
```

🌞 Analyser les processus liés au service SSH :
```
[it4@localhost ~]$ ps -ef | grep sshd
root         687       1  0 16:45 ?        00:00:00 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
root         867     687  0 16:45 ?        00:00:00 sshd: it4 [priv]
it4          881     867  0 16:46 ?        00:00:00 sshd: it4@pts/0
it4          975     882  0 17:08 pts/0    00:00:00 grep --color=auto sshd
```

🌞 Déterminer le port sur lequel écoute le service SSH :
```
[it4@localhost ~]$ sudo ss -alnpt | grep ssh
LISTEN 0      128          0.0.0.0:22        0.0.0.0:*    users:(("sshd",pid=687,fd=3))
LISTEN 0      128             [::]:22           [::]:*    users:(("sshd",pid=687,fd=4))
```

🌞 Consulter les logs du service SSH :
```
[it4@localhost ~]$ journalctl | tail -n 10
Nov 22 17:01:01 localhost.localdomain anacron[939]: Anacron started on 2022-11-22
Nov 22 17:01:01 localhost.localdomain anacron[939]: Will run job `cron.daily' in 33 min.
Nov 22 17:01:01 localhost.localdomain anacron[939]: Will run job `cron.weekly' in 53 min.
Nov 22 17:01:01 localhost.localdomain anacron[939]: Will run job `cron.monthly' in 73 min.
Nov 22 17:01:01 localhost.localdomain anacron[939]: Jobs will be executed sequentially
Nov 22 17:01:01 localhost.localdomain run-parts[941]: (/etc/cron.hourly) finished 0anacron
Nov 22 17:01:01 localhost.localdomain CROND[925]: (root) CMDEND (run-parts /etc/cron.hourly)
Nov 22 17:18:36 localhost.localdomain sudo[1039]:      it4 : TTY=pts/0 ; PWD=/home/it4 ; USER=root ; COMMAND=/sbin/ss -alnpt
Nov 22 17:18:36 localhost.localdomain sudo[1039]: pam_unix(sudo:session): session opened for user root(uid=0) by it4(uid=1000)
Nov 22 17:18:36 localhost.localdomain sudo[1039]: pam_unix(sudo:session): session closed for user root
```

2. Modification du service

🌞 Identifier le fichier de configuration du serveur SSH :
```
[it4@localhost ~]$ cd /etc/ssh/
[it4@localhost ssh]$ ls -al
-rw-------.  1 root root       3669 Sep 20 20:46 sshd_config
```

🌞 Modifier le fichier de conf :
```
[it4@localhost ~]$ echo $RANDOM
16092
```
```
[it4@localhost ~]$ sudo cat /etc/ssh/sshd_config | grep Port
#Port 16092
```
```
[it4@localhost ~]$ sudo firewall-cmd --remove-service=ssh --permanent
[it4@localhost ~]$ sudo firewall-cmd --reload
success
[it4@localhost ~]$ sudo firewall-cmd --list-all | grep ports
  ports: 16092/tcp
```

🌞 Redémarrer le service :
```
[it4@localhost ~]$ sudo systemctl restart sshd
```

🌞 Effectuer une connexion SSH sur le nouveau port :
```
PS C:\Users\lebou> ssh it4@10.2.3.5 -p 16092
it4@10.2.3.5' s password:
Last login: Tue Dec 13 14:40:35 2022 from 10.2.3.1
```

II. Service HTTP :

1. Mise en place

🌞 Installer le serveur NGINX :
```
[it4@localhost ~]$ sudo dnf install nginx
Complete!
```

🌞 Démarrer le service NGINX :
```
[it4@localhost ~]$ sudo systemctl start nginx
```

🌞 Déterminer sur quel port tourne NGINX :
```
[it4@localhost ~]$ sudo ss -alnpt | grep nginx
[sudo] password for it4:
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=11112,fd=6),("nginx",pid=11111,fd=6))
LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=11112,fd=7),("nginx",pid=11111,fd=7))

[it4@localhost ~]$ sudo firewall-cmd --permanent --add-port=80/tcp
success
```

🌞 Déterminer les processus liés à l'exécution de NGINX :
```
[it4@localhost ~]$ ps -ef | grep nginx
root         952       1  0 17:41 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx        953     818  0 17:41 ?        00:00:00 nginx: worker process
it4         968     841  0 21:42 pts/0    00:00:00 grep --color=auto nginx
```

🌞 Euh wait :
```
lebou@LAPTOP-R8S29PG0 MINGW64 ~
$ curl 10.2.3.5:80 | head -n7  
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7620  100  7620    0     0   875k      0 --:--:-- --:--:-- --:--:-- 2480k
<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
```

2. Analyser la conf de NGINX

🌞 Déterminer le path du fichier de configuration de NGINX :
```
[it4@localhost ~]$ sudo find /etc -iname nginx.conf
/etc/nginx/nginx.conf
```

🌞 Trouver dans le fichier de conf :
```
[it4@localhost ~]$ sudo cat /etc/nginx/nginx.conf | grep server -A 12
    server {
        listen       80;
        listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        error_page 404 /404.html;
        location = /404.html {
        }
```
```
[it4@localhost nginx]$cat nginx.conf | grep -i '^ *include'
    include /etc/nginx/conf.d/*.conf;
```

3. Déployer un nouveau site web

🌞 Créer un site web :
```

```