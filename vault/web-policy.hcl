path "secret/data/*" {
  capabilities = ["create", "update"]
}

# Read web credentials
path "database/static-creds/dev-web*"
{
  capabilities = ["read"]
}
