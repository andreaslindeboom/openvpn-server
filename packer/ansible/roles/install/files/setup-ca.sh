#!/bin/bash
# Since Ansible uses /bin/sh and does not allow us to use source, this needs to be solved in a tricky way...
cd /etc/openvpn/easy-rsa
source ./vars
./clean-all
./build-ca --batch
./build-key-server --batch $1
./build-dh
