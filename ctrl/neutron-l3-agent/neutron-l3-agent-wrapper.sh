#!/bin/bash

set -o errexit


neutron-l3-agent \
        --config-file /etc/neutron/neutron.conf \
        --config-file /etc/neutron/l3_agent.ini
