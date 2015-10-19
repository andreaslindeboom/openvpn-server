provider "digitalocean" {
    token = "${var.digitalocean.access_token}"
}

resource "digitalocean_ssh_key" "openvpn-server" {
    name = "${var.ssh_key.name}"
    public_key = "${file(var.ssh_key.public_key_path)}"
}

