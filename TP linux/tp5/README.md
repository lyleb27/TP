TP5 : Self-hosted cloud

Partie 1 : Mise en place et maîtrise du serveur Web :

🌞 Installer le serveur Apache :
```
[it4@localhost ~]$ sudo dnf install httpd -y
Complete!
```

🌞 Démarrer le service Apache :
```
[it4@localhost ~]$ sudo systemctl start httpd.service
```
```
[it4@localhost ~]$ sudo systemctl enable httpd.service
Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
```
```
[it4@localhost ~]$ sudo ss -alnpt | grep httpd
LISTEN 0      511                *:80              *:*    users:(("httpd",pid=10868,fd=4),("httpd",pid=10867,fd=4),("httpd",pid=10866,fd=4),("httpd",pid=10864,fd=4))
```
```
[it4@localhost ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
[sudo] password for it4:
success
```

🌞 TEST :
```
[it4@localhost ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
     Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
     Active: active (running) since Mon 2022-12-12 15:41:15 CET; 26min ago
Dec 12 15:41:15 localhost.localdomain httpd[10864]: Server configured, listening on: port 80
```
```
[it4@localhost ~]$ curl localhost | grep apache
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  7620  100  7620    0     0   531k      0 --:--:-- --:--:-- --:--:--  572k
        <a href="https://httpd.apache.org/">Apache Webserver</strong></a>:
      <a href="https://apache.org">Apache&trade;</a> is a registered trademark of <a href="https://apache.org">the Apache Software Foundation</a> in the United States and/or other countries.<br />
```
```
[it4@localhost ~]$ curl https://httpd.apache.org/
```


🌞 Déterminer sous quel utilisateur tourne le processus Apache :
``
[it4@localhost ~]$ cat /etc/httpd/conf/httpd.conf | grep User
User apache
```
```
[it4@localhost ~]$ ps -ef | grep apache
apache     10865   10864  0 15:41 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache     10866   10864  0 15:41 ?        00:00:01 /usr/sbin/httpd -DFOREGROUND
apache     10867   10864  0 15:41 ?        00:00:01 /usr/sbin/httpd -DFOREGROUND
apache     10868   10864  0 15:41 ?        00:00:01 /usr/sbin/httpd -DFOREGROUND
```
```
[it4@localhost testpage]$ ls -al
total 12
drwxr-xr-x.  2 apache root   24 Dec 12 15:35 .
drwxr-xr-x. 82 root   root 4096 Dec 12 15:35 ..
-rw-r--r--.  1 root   root 7620 Jul 27 20:05 index.html
```

🌞 Changer l'utilisateur utilisé par Apache :
```

```