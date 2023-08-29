ui            = false
cluster_addr  = "https://127.0.0.1:8201"
api_addr      = "https://127.0.0.1:8200"
disable_mlock = true

storage "file" {
        path = "/vault/file"
}

listener "tcp" {
    address = "0.0.0.0:8200"
    tls_disable = true
}

default_lease_ttl = "168h"
max_lease_ttl = "720h"
