#!/bin/bash

# Суть: бьем службы, с ними вместе автоматом падают процессы, поднимаем службы и проверяем процессы
# Цель: все необходимые службы перезапущены, поднимаются два процесса.
# Примечание: 1. намазано много функций sleep для более удобного наблюдения. 2. поднял hostname отдельно, служба появляется сама только через время после запуска демона



echo "Checking out current OVS state..."
sleep 2

if systemctl list-units —type=service | grep -q "ovs-vswitchd.service" && systemctl list-units —type=service | grep -q "ovsdb-server.service"; then
    echo "ovs-vswitchd.service is running."
    echo "ovsdb-server.service is running."
    systemctl stop ovsdb-server.service
    systemctl stop ovs-vswitchd.service
    systemctl start ovs-vswitchd.service
    systemctl start ovsdb-server.service
    echo "OpenVSwitch DB and Daemon have been restarted."
    echo
else

    #ветка else не закончена
    echo "ovs-vswitchd.service is not running."
fi


###ВЕТКА ДЛЯ OVSCLEAR
#!/usr/bin/env bash

### vars
_bonds=(backplane1 mgmt public)


###
for _bond in ${_bonds[@]}; do
  printf "/i/ bond <= ${_bond} ..\n"

  printf "/i/ removing ports from ${_bond} ..\n"
  ovs-vsctl del-port ${_bond} bond-${_bond}
  ovs-vsctl del-port ${_bond} mgmt
  ovs-vsctl del-port ${_bond} public

  printf "/i/ removing bridge${_bond} ..\n"
  ovs-vsctl del-br ${_bond}
  done
###ВЕТКА ДЛЯ OVSCLEAR

echo "Checking out OvS processes..."
sleep 2
if ps -e | grep -q "ovsdb" && ps -e | grep -q "vswitchd"; then
echo "Both OVS DB and OVS Daemon processes are running"
ps -e | grep "ovs"
else
echo "ERROR: Either OVS DB or OVS Daemon process is not running"
ps -e | grep "ovs"
fi
