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

```