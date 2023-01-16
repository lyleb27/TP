Partie 2 : Serveur de partage de fichiers :

🌞 Donnez les commandes réalisées sur le serveur NFS storage.tp4.linux :
```
[it4@storage ~]$ cat /etc/exports
/storage/site_web_1/        10.2.3.8(rw,sync,no_root_squash,no_subtree_check)
/storage/site_web_2/        10.2.3.8(rw,sync,no_root_squash,no_subtree_check)
```

🌞 Donnez les commandes réalisées sur le client NFS web.tp4.linux :
```
[it4@web ~]$ cat /etc/fstab | grep 10.2.3.9
10.2.3.9:/storage/site_web_1    /var/www/site_web_1   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
10.2.3.9:/storage/site_web_2    /var/www/site_web_2   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0
```