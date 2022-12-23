#!/bin/bash

echo "Machine name : $(hostnamectl --static)"
echo "OS $(cat /etc/redhat-release) and kernel version is $(uname)"
echo "IP : $(ip a | grep "inet " | tail -n1 | tr -s ' ' | cut -d ' ' -f3)"
echo "RAM : $(free -h --mega | grep Mem: | tr -s ' ' | cut -d' ' -f7) memory available on $(free -h --mega | grep Mem: | tr -s ' ' | cut -d' ' -f2) total memory"
echo "Disk : $(df -H -a | grep " /$" | tr -s ' ' | cut -d' ' -f4) space left"
echo "Top 5 processes by RAM usage :"
a="$(ps -e -o %mem=,cmd= --sort=-%mem  | head -n5)"
while read processes
do
echo - $processes
done <<< "${a}"
z="$(ss -ltn4H | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f2)"
echo "Listening ports :"
while read tcp
do
echo - $tcp tcp : sshd
done <<<"${z}"
y="$(ss -lun4H | tr -s ' ' | cut -d' ' -f4 | cut -d':' -f2)"
while read udp
do 
echo  - $udp udp : sshd
done <<<"${y}"


echo "Here is your random cat : ./cat.jpg"
