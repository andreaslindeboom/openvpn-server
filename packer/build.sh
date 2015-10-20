#!/bin/bash
packer build --var-file=secrets.json --var "base_image=$(cat ~/.packer.d/.ansible-base.snapshot_id)" --only=digitalocean -machine-readable openvpn-server.json |\
    tee >(grep 'artifact,0,id' | cut -d, -f6 | cut -d: -f2 > ../.openvpn-server.snapshot_id)
