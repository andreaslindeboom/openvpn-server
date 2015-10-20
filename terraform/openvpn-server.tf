resource "digitalocean_droplet" "openvpn-server" {
    image = "${file("../.openvpn-server.snapshot_id")}"
    name = "openvpn-server"
    region = "ams3"
    size = "512mb"
    ssh_keys = ["${digitalocean_ssh_key.openvpn-server.id}"]
    private_networking = true
}
