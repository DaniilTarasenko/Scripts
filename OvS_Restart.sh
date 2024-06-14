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

  printf "Stopping OpenVSwitch services"
  systemctl stop service ovs-vswitchd.service
  systemctl stop service ovsdb-server.service

  printf "Starting OpenVSwitch services"
  systemctl start service ovs-vswitchd.service
  systemctl start ovsdb-server.service

  done

