TP5 : Self-hosted cloud

Partie 1 : Mise en place et maîtrise du serveur Web :

1. Installation

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
[it4@localhost ~]$ curl localhost | head -n 10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {
100  7620  100  7620    0     0   338k      0 --:--:-- --:--:-- --:--:--  338k
curl: (23) Failed writing body
```

2. Avancer vers la maîtrise du service

🌞 Le service Apache... :
```
[it4@localhost ~]$ cat /usr/lib/systemd/system/httpd.service
# See httpd.service(8) for more information on using the httpd service.

# Modifying this file in-place is not recommended, because changes
# will be overwritten during package upgrades.  To customize the
# behaviour, run "systemctl edit httpd" to create an override unit.

# For example, to pass additional options (such as -D definitions) to
# the httpd binary at startup, create an override unit (as is done by
# systemctl edit) and enter the following:

#       [Service]
#       Environment=OPTIONS=-DMY_DEFINE

[Unit]
Description=The Apache HTTP Server
Wants=httpd-init.service
After=network.target remote-fs.target nss-lookup.target httpd-init.service
Documentation=man:httpd.service(8)

[Service]
Type=notify
Environment=LANG=C

ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND
ExecReload=/usr/sbin/httpd $OPTIONS -k graceful
# Send SIGWINCH for graceful stop
KillSignal=SIGWINCH
KillMode=mixed
PrivateTmp=true
OOMPolicy=continue

[Install]
WantedBy=multi-user.target
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
[it4@localhost testpage]$ ls -al | grep index
-rw-r--r--.  1 root   root 7620 Jul 27 20:05 index.html
```

🌞 Changer l'utilisateur utilisé par Apache :
```
[it4@localhost ~]$ sudo useradd apache_usr -d /usr/share/httpd -s /sbin/nologin
[sudo] password for it4:
useradd: warning: the home directory /usr/share/httpd already exists.
useradd: Not copying any file from skel directory into it.
```
```
[it4@localhost ~]$ cat /etc/passwd | grep apache_usr
apache_usr:x:1001:1001::/usr/share/httpd:/sbin/nologin
```
```
[it4@localhost ~]$ sudo chown -R apache_usr:apache_usr /usr/share/testpage/
[sudo] password for it4:
```
```
[it4@localhost testpage]$ ls -al | grep index
-rw-r--r--.  1 apache_usr apache_usr 7620 Jul 27 20:05 index.html
```
```
[it4@localhost ~]$ sudo systemctl restart httpd
```
```
[it4@localhost ~]$ ps -ef | grep httpd
root        1375       1  0 22:31 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1377    1375  0 22:31 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1378    1375  0 22:31 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1379    1375  0 22:31 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
apache      1380    1375  0 22:31 ?        00:00:00 /usr/sbin/httpd -DFOREGROUND
it4         1595    1093  0 22:34 pts/0    00:00:00 grep --color=auto httpd
```

🌞 Faites en sorte que Apache tourne sur un autre port :
```
[it4@localhost ~]$ sudo vim /etc/httpd/conf/httpd.conf
```
```
[it4@localhost ~]$ cat /etc/httpd/conf/httpd.conf | grep Listen
Listen 27
```
```
[it4@localhost ~]$ sudo firewall-cmd --add-port=27/tcp --permanent
success
```
```
[it4@localhost ~]$ sudo firewall-cmd --remove-port=80/tcp --permanent
success
```
```
[it4@localhost ~]$ sudo systemctl restart httpd
```
```
[it4@localhost ~]$ ss -tulpn | grep :27
tcp   LISTEN 0      511                *:27              *:*
```
```
[it4@localhost ~]$ curl localhost:27 | head -n 10
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0<!doctype html>
<html>
  <head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>HTTP Server Test Page powered by: Rocky Linux</title>
    <style type="text/css">
      /*<![CDATA[*/

      html {
100  7620  100  7620    0     0   572k      0 --:--:-- --:--:-- --:--:--  572k
curl: (23) Failed writing body
```
📁 Fichier /etc/httpd/conf/httpd.conf :