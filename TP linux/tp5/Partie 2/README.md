Partie 2 : Mise en place et maîtrise du serveur de base de données

🌞 Install de MariaDB sur db.tp5.linux :
```
[it4@db ~]$ sudo dnf install mariadb-server
Complete!
```
```
[it4@db ~]$ sudo systemctl enable mariadb
Created symlink /etc/systemd/system/mysql.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/mysqld.service → /usr/lib/systemd/system/mariadb.service.
Created symlink /etc/systemd/system/multi-user.target.wants/mariadb.service → /usr/lib/systemd/system/mariadb.service.
```
```
[it4@db ~]$ sudo systemctl start mariadb
```
```
[it4@db ~]$ sudo mysql_secure_installation
All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

🌞 Port utilisé par MariaDB :
```
[it4@db ~]$ sudo ss -alnpt | grep mariadb
LISTEN 0      80                 *:3306            *:*    users:(("mariadbd",pid=3749,fd=19))
```
```
[it4@db ~]$ sudo firewall-cmd --add-port=3306/tcp --permanent
success
```
```
[it4@db ~]$ sudo firewall-cmd --reload
success
```

🌞 Processus liés à MariaDB :
```
[it4@db ~]$ sudo ps -aux | grep mariadb
mysql       3749  0.0  9.9 1085164 97712 ?       Ssl  14:27   0:00 /usr/libexec/mariadbd --basedir=/usr
it4         3932  0.0  0.2   6412  2332 pts/0    S+   14:59   0:00 grep --color=auto mariadb
```