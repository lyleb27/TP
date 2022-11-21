TP1 : Are you dead yet ?

🌞 Trouver au moins 4 façons différentes de péter la machine :

- [root@localhost ~]# sudo rm -r /etc/security/

Après avoir supprimé </security>, la VM est entrée en mode rescue.

- [root@localhost ~]# sudo rm -r /sbin/

J'ai supprimé le programme </sbin> qui coordonne le processus de démarrage et configure l'environnement de l'utilisateur. La VM démarre mais ne nous permet pas d'accéder à notre environnement.

- [root@localhost ~]# sudo rm -r /boot/  

En supprimant </boot> j'ai arrêté la procédure de démarrage de la VM.