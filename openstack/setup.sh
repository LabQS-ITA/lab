#!/usr/bin/env bash
set -euo pipefail

export ADMIN_PASS=s3cr37
export CONTROLLER=localhost

export DEBIAN_FRONTEND=noninteractive

apt-get update -y && apt-get upgrade -y && \
apt-get install -y keystone && \
/bin/sh -c "keystone-manage db_sync" keystone && \
keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone && \
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone && \
keystone-manage bootstrap --bootstrap-password ${ADMIN_PASS} \
    --bootstrap-admin-url https://${CONTROLLER}/keystone/v3 \
    --bootstrap-internal-url https://${CONTROLLER}/keystone/v3 \
    --bootstrap-public-url https://${CONTROLLER}/keystone/v3 \
    --bootstrap-region-id RegionOne

export SVC_PWD=$(openssl rand -hex 8) > .env
export MARIADB_PWD=$(awk -F = $1 == $SVC_PWD  {print $2} ../mariadb/.env) >> .env

sed -i 's/@MARIADB_PWD/'$(awk -F'=' '$1 =="SVC_PWD" {print $2}' ../mariadb/.env)'/g' ./config/keystone/keystone.conf

export OS_USERNAME: admin
export OS_PASSWORD: ${SVC_PWD}
export OS_PROJECT_NAME: admin
export OS_USER_DOMAIN_NAME: Default
export OS_PROJECT_DOMAIN_NAME: Default
export OS_AUTH_URL: https://${LAB_DOMAIN}/keystone/v3
export OS_IDENTITY_API_VERSION: 3
