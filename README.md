# OpenVPN-Deploy
[WIP] A set of Packer builders and Terraform configuration to build and deploy an OpenVPN server that is set up solely to reach a private network the OpenVPN server is on.

NOTE: work on this is not yet complete! It also requires https://github.com/andreaslindeboom/ansible-base-image to be run once. (this is temporary)

##Building the image
###Preparation
If you intend to create DigitalOcean snapshots, copy `packer/secrets.json.dist` to `secrets.json,` and enter your DigitalOcean access token.

To configure the CA, an `openvpn-config.yml.dist` file is included in the `packer` directory. Copy this to `openvpn-config.yml` and enter your details.

In addition, enter the IP + subnet mask of the private network you are trying to reach through the VPN server.

###DigitalOcean Snapshot
A wrapper scripts is included to build a snapshot on DigitalOcean. To build the snapshot, `cd` into the `packer` directory and run `build.sh`.

Note that this script will write out the id of the created snapshot to .openvpn.snapshot_id in the project root to be used by Terraform later. For this reason, Packer will be run with the --machine-readable flag.

##Provisioning to DigitalOcean
###Preparations
Copy `terraform/secrets.tf.dist` to `terraform/secrets.tf` and enter your DigitalOcean access token.

Also, copy `terraform/ssh_key.tf.dist` to `terraform/ssh_key.tf` and enter a unique name for your SSH key, as well as the paths to your private and public key. (the private key will only be used by SSH for remote provisioning)
You can use an existing one or create a new one with `ssh-keygen`. Note that the same SSH key can not already be present on your DigitalOcean account unless it is being managed by Terraform, or provisioning will fail.

###Preview or execute provisioning
To preview what Terraform would do, run `terraform plan` from the `terraform` directory.

To provision the nodes, run `terraform apply` from the `terraform` directory.

Note that valid DigitalOcean snapshot ids from the Packer build step are expected to be present in the following files in the project root: `.openvpn.snapshot_id`.

After provisioning, run `terraform show` to get the IP addresses of the newly created instance.

##Troubleshooting
###Provisioning fails because ‘SSH Key is already in use on your account’
This can be remediated either by using a different key, or by deleting the SSH key from your DigitalOcean account. Terraform will then add it and it will become a Terraform managed resource.

###Provisioning fails because of ‘unprocessable_entity: You specified an invalid image for Droplet creation’
The snapshot id is either not present or the snapshot does not exist in your DigitalOcean account or zone.
