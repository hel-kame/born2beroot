#!/bin/bash

ARCH=$(uname -a)
CPU_P=$(cat /proc/cpuinfo | grep -c "^physical id")
CPU_V=$(cat /proc/cpuinfo | grep -c "^processor")
MEM_USED=$(free -m | grep "Mem" | awk '{print $3}')
MEM_TOTAL=$(free -m | grep "Mem" | awk '{print $2}')
MEM_PERCENT=$(free -m | grep "Mem" | awk '{print $3/$2 * 100}')
DISK_USED=$(df -m --total | grep "total" | awk '{print $3}')
DISK_TOTAL=$(df -h --total | grep "total" | awk '{print $2}')
CPU_LOAD=$(top -bn1 | grep "^%Cpu(s)" | awk '{print $4}')
DISK_PERCENT=$(df -h --total | grep "total" | awk '{print $5}')
LAST_REBOOT=$(who -b | awk '{print $3" "$4}')
LVM_CHECK=$(lsblk | grep "lvm" | wc -l)
TCP_CONNEXION=$(netstat -natp | grep "ESTABLISHED" | wc -l)
USER_LOG=$(who -T | grep "+" | wc -l)
IP_ADDRESS=$(hostname -I)
MAC_ADDRESS=$(ip link show | grep "link/ether" | awk '{print $2}')
SUDO_CMD=$(cat /var/log/sudo/sudo.log | grep "COMMAND" | wc -l)

monitoring()
{
        echo "\t#Architecture: ${ARCH}"
        echo "\t#CPU physical : ${CPU_P}"
        echo "\t#vCPU : ${CPU_V}"
        echo "\t#Memory Usage: ${MEM_USED}/${MEM_TOTAL}MB (${MEM_PERCENT}%)"
        echo "\t#Disk Usage: ${DISK_USED}/${DISK_TOTAL}b (${DISK_PERCENT})"
        echo "\t#CPU load: ${CPU_LOAD}%"
        echo "\t#Last boot: ${LAST_REBOOT}"
        if [ ${LVM_CHECK} -eq 0 ]; then
                echo "\t#LVM use: no";
        else
                echo "\t#LVM use: yes";
        fi
        echo "\t#Connexions TCP : ${TCP_CONNEXION} ESTABLISHED"
        echo "\tUser log: ${USER_LOG}"
        echo "\tNetwork: IP ${IP_ADDRESS}(${MAC_ADDRESS})"
        echo "\tSudo: ${SUDO_CMD} cmd"
}
monitoring | wall
