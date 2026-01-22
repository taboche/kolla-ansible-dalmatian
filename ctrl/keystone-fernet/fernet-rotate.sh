#!/bin/bash

set -o errexit
set -o pipefail

keystone-manage --config-file /etc/keystone/keystone.conf fernet_rotate --keystone-user keystone --keystone-group keystone

/usr/bin/fernet-push.sh
