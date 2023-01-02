Module 4 : Monitoring :

🌞 Installer Netdata :
```
[it4@db ~]$ sudo ss -tlpn | grep netdata
LISTEN 0      4096         0.0.0.0:19999      0.0.0.0:*    users:(("netdata",pid=41318,fd=6))


[it4@web ~]$ sudo ss -tlpn | grep netdata                          
LISTEN 0      4096         0.0.0.0:19999      0.0.0.0:*    users:(("netdata",pid=45410,fd=6))
```

🌞 Une fois Netdata installé et fonctionnel, déterminer :
```
[it4@db ~]$ ps -ef | grep netdata
root       41020       1  0 16:50 ?        00:00:00 gpg-agent --homedir /var/cache/dnf/netdata-edge-a383c484584e0b14/pubring --use-standard-socket --daemon
root       41022   41020  0 16:50 ?        00:00:00 scdaemon --multi-server --homedir /var/cache/dnf/netdata-edge-a383c484584e0b14/pubring
root       41188       1  0 16:51 ?        00:00:00 gpg-agent --homedir /var/cache/dnf/netdata-repoconfig-3ca68ffb39611f32/pubring --use-standard-socket --daemon
root       41190   41188  0 16:51 ?        00:00:00 scdaemon --multi-server --homedir /var/cache/dnf/netdata-repoconfig-3ca68ffb39611f32/pubring
netdata    41318       1  1 16:52 ?        00:00:06 /usr/sbin/netdata -P /run/netdata/netdata.pid -D
netdata    41320   41318  0 16:52 ?        00:00:00 /usr/sbin/netdata --special-spawn-server
root       41508   41318  0 16:52 ?        00:00:00 /usr/libexec/netdata/plugins.d/ebpf.plugin 1
netdata    41513   41318  0 16:52 ?        00:00:03 /usr/libexec/netdata/plugins.d/apps.plugin 1
netdata    41514   41318  0 16:52 ?        00:00:01 /usr/libexec/netdata/plugins.d/go.d.plugin 1
netdata    41516   41318  0 16:52 ?        00:00:00 bash /usr/libexec/netdata/plugins.d/tc-qos-helper.sh 1
it4        41953     967  0 17:00 pts/0    00:00:00 grep --color=auto netdata


[it4@web ~]$ ps -ef | grep netdata
root       45164       1  0 16:34 ?        00:00:00 gpg-agent --homedir /var/cache/dnf/netdata-edge-a383c484584e0b14/pubring --use-standard-socket --daemon
root       45166   45164  0 16:34 ?        00:00:00 scdaemon --multi-server --homedir /var/cache/dnf/netdata-edge-a383c484584e0b14/pubring
root       45207       1  0 16:34 ?        00:00:00 gpg-agent --homedir /var/cache/dnf/netdata-repoconfig-3ca68ffb39611f32/pubring --use-standard-socket --daemon
root       45209   45207  0 16:34 ?        00:00:00 scdaemon --multi-server --homedir /var/cache/dnf/netdata-repoconfig-3ca68ffb39611f32/pubring
netdata    45410       1  1 16:36 ?        00:00:16 /usr/sbin/netdata -P /run/netdata/netdata.pid -D
netdata    45412   45410  0 16:36 ?        00:00:00 /usr/sbin/netdata --special-spawn-server
netdata    45588   45410  0 16:36 ?        00:00:01 bash /usr/libexec/netdata/plugins.d/tc-qos-helper.sh 1
netdata    45594   45410  1 16:36 ?        00:00:20 /usr/libexec/netdata/plugins.d/apps.plugin 1
netdata    45596   45410  0 16:36 ?        00:00:04 /usr/libexec/netdata/plugins.d/go.d.plugin 1
root       45599   45410  0 16:36 ?        00:00:00 /usr/libexec/netdata/plugins.d/ebpf.plugin 1
it4        46118    1099  0 16:59 pts/0    00:00:00 grep --color=auto netdata
```
```
[it4@db ~]$ sudo ss -alnpt | grep netdata
[sudo] password for it4:
LISTEN 0      4096       127.0.0.1:8125       0.0.0.0:*    users:(("netdata",pid=41318,fd=49))
LISTEN 0      4096         0.0.0.0:19999      0.0.0.0:*    users:(("netdata",pid=41318,fd=6))
LISTEN 0      4096           [::1]:8125          [::]:*    users:(("netdata",pid=41318,fd=48))
LISTEN 0      4096            [::]:19999         [::]:*    users:(("netdata",pid=41318,fd=7))


[it4@web ~]$ sudo ss -alnpt | grep netdata
LISTEN 0      4096       127.0.0.1:8125       0.0.0.0:*    users:(("netdata",pid=45410,fd=67))                          
LISTEN 0      4096         0.0.0.0:19999      0.0.0.0:*    users:(("netdata",pid=45410,fd=6))                           
LISTEN 0      4096           [::1]:8125          [::]:*    users:(("netdata",pid=45410,fd=66))                          
LISTEN 0      4096            [::]:19999         [::]:*    users:(("netdata",pid=45410,fd=7))
```
```
[it4@web ~]$ ls /var/log/netdata/
access.log  debug.log  error.log  health.log

[it4@db ~]$ ls /var/log/netdata/
access.log  debug.log  error.log  health.log
```

🌞 Configurer Netdata pour qu'il vous envoie des alertes :
```

```

🌞 Vérifier que les alertes fonctionnent :
```

```