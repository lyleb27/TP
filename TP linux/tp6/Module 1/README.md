TP6 : Travail autour de la solution NextCloud :

Module 1 : Reverse Proxy

🌞 On utilisera NGINX comme reverse proxy :
```
[it4@proxy ~]$ sudo dnf install nginx
Complete!

[it4@proxy ~]$ sudo systemctl start nginx

[it4@proxy ~]$ sudo ss -tlpn | grep nginx
LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=10760,fd=6),("nginx",pid=10759,fd=6))
LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=10760,fd=7),("nginx",pid=10759,fd=7))

[it4@proxy ~]$ sudo firewall-cmd --add-port=80/tcp --permanent
success
[it4@proxy ~]$ sudo firewall-cmd --reload
success

[it4@proxy ~]$ ps -ef | grep nginx
root       10759       1  0 15:31 ?        00:00:00 nginx: master process /usr/sbin/nginx
nginx      10760   10759  0 15:31 ?        00:00:00 nginx: worker process
it4        10819   10793  0 15:40 pts/0    00:00:00 grep --color=auto nginx
```

🌞 Configurer NGINX :
```

```

