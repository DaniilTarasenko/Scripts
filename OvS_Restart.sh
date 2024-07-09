#!/usr/bin/env bash
OVS_CHECK(){
        echo "Checking out current OVS state..."
        sleep 2

        ###бэкап бд перед сносом ovs-clear
        cp /var/lib/openvswitch/conf.db /var/lib/openvswitch/backup

        ###OVSCLEAR
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
        ### OVSCLEAR

        ### Примечание: после перезапуска службы vswitchd не происходит автоматического добавления бриджей и портов, это необходимо восстанавливать

        mv /var/lib/openvswitch/backup /var/lib/openvswitch/conf.db
        systemctl restart ovs-vswitchd.service
        systemctl restart ovsdb-server.service

        echo "Checking out OvS processes..."
        sleep 2
        if ps -e | grep -q "ovsdb" && ps -e | grep -q "vswitchd"; then
        echo "Both OVS DB and OVS Daemon processes are running"
        ps -e | grep "ovs"
        else
        echo "ERROR: Either OVS DB or OVS Daemon process is not running"
        ps -e | grep "ovs"
        fi
}
OVS_CHECK
