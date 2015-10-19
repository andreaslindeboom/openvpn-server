#!/bin/bash
packer build --var-file=packer/secrets.json --only=digitalocean -machine-readable packer/openvpn-server.json |\
    tee >(grep 'artifact,0,id' | cut -d, -f6 | cut -d: -f2 > .openvpn-server.snapshot_id)
