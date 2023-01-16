Partie 3 : Configuration et mise en place de NextCloud :

1. Base de données

🌞 Préparation de la base pour NextCloud :
```
[it4@db ~]$ sudo mysql -u root -p
Enter password:
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 7
Server version: 10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE USER 'nextcloud'@'10.105.1.11' IDENTIFIED BY 'pewpewpew'
    -> ;
Query OK, 0 rows affected (0.009 sec)

MariaDB [(none)]> CREATE DATABASE IF NOT EXISTS nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
Query OK, 1 row affected (0.000 sec)

MariaDB [(none)]> GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'10.105.1.11';
Query OK, 0 rows affected (0.003 sec)

MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.001 sec)

MariaDB [(none)]> Ctrl-C -- exit!
Aborted
```

🌞 Exploration de la base de données :
```
[it4@web ~]$ sudo dnf install mysql
Complete!
```
```
[it4@web ~]$ sudo mysql -u nextcloud -h 10.105.1.11 -pewpewpew
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 7
Server version: 5.5.5-10.5.16-MariaDB MariaDB Server

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| nextcloud          |
+--------------------+
2 rows in set (0.01 sec)

mysql> USE nextcloud
Database changed
mysql> SHOW TABLES;
Empty set (0.00 sec)

mysql>
```

🌞 Trouver une commande SQL qui permet de lister tous les utilisateurs de la base de données :
```
MariaDB [mysql]> select host,user from user;
+-------------+-------------+
| Host        | User        |
+-------------+-------------+
| 10.105.1.11 | nextcloud   |
| localhost   | mariadb.sys |
| localhost   | mysql       |
| localhost   | root        |
+-------------+-------------+
4 rows in set (0.001 sec)
```

2. Serveur Web et NextCloud

🌞 Install de PHP :
```
[it4@web ~]$ sudo dnf config-manager --set-enabled crb

[it4@web ~]$ sudo dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
Complete!

[it4@web ~]$ sudo dnf module enable php:remi-8.1 -y
Complete!

[it4@web ~]$ sudo dnf install -y php81-php
Complete!
```

🌞 Install de tous les modules PHP nécessaires pour NextCloud :
```
[it4@web ~]$ sudo dnf install -y libxml2 openssl php81-php php81-php-ctype php81-php-curl php81-php-gd php81-php-iconv php81-php-json php81-php-libxml php81-php-mbstring php81-php-openssl php81-php-posix php81-php-session php81-php-xml php81-php-zip php81-php-zlib php81-php-pdo php81-php-mysqlnd php81-php-intl php81-php-bcmath php81-php-gmp
Complete!
```

🌞 Récupérer NextCloud :
```
[it4@web ~]$ curl -o nextcloud https://download.nextcloud.com/server/prereleases/nextcloud-25.0.0rc3.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  168M  100  168M    0     0  29.8M      0  0:00:05  0:00:05 --:--:-- 35.3M

[it4@web ~]$ sudo dnf install unzip -y
Complete!

[it4@web ~]$ sudo unzip nextcloud -d /var/www/tp5_nextcloud/
```

🌞 Adapter la configuration d'Apache :
```
[it4@web ~]$ sudo cat /etc/httpd/conf.d/nextcloud.conf
<VirtualHost *:80>
  # on indique le chemin de notre webroot
  DocumentRoot /var/www/tp5_nextcloud/
  # on précise le nom que saisissent les clients pour accéder au service
  ServerName  web.tp5.linux

  # on définit des règles d'accès sur notre webroot
  <Directory /var/www/tp5_nextcloud/>
    Require all granted
    AllowOverride All
    Options FollowSymLinks MultiViews
    <IfModule mod_dav.c>
      Dav off
    </IfModule>
  </Directory>
</VirtualHost>
```

🌞 Redémarrer le service Apache pour qu'il prenne en compte le nouveau fichier de conf :
```
[it4@web ~]$ sudo systemctl restart httpd
```

3. Finaliser l'installation de NextCloud

🌞 Exploration de la base de données :
```
MariaDB [(none)]> SELECT count(*) AS number FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'nextcloud';
+--------+
| number |
+--------+
|     95 |
+--------+
1 row in set (0.002 sec)
```