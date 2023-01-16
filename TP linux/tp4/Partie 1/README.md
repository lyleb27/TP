TP4 : Real services

Partie 1 : Partitionnement du serveur de stockage :

🌞 Partitionner le disque à l'aide de LVM :
```
[it4@storage ~]$ sudo pvcreate /dev/sdb
[sudo] password for it4:
  Physical volume "/dev/sdb" successfully created.

[it4@storage ~]$ sudo vgcreate storage /dev/sdb
  Volume group "storage" successfully created

[it4@storage ~]$ sudo lvcreate -l 100%FREE storage -n storage
  Logical volume "storage" created.
```

🌞 Formater la partition :
```
[it4@storage ~]$ sudo mkfs -t ext4 /dev/storage/storage
mke2fs 1.46.5 (30-Dec-2021)
Creating filesystem with 523264 4k blocks and 130816 inodes
Filesystem UUID: 2bb02039-8bee-4731-a22e-f6076162842d
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912

Allocating group tables: done
Writing inode tables: done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: done
```

🌞 Monter la partition :
```
[it4@storage ~]$ df -h | grep storage
/dev/mapper/storage-storage  2.0G   24K  1.9G   1% /mnt/storage

[it4@storage ~]$ sudo chown it4 /mnt/storage/

[it4@storage storage]$ nano test
[it4@storage storage]$ cat test
test

[it4@storage ~]$ cat /etc/fstab | grep storage
/dev/storage/storage /mnt/storage       ext4     defaults        0 0

[it4@storage ~]$ sudo mount -av
/mnt/storage             : successfully mounted
```

