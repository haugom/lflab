#!/usr/bin/env bash

master_ip0=$(jq '.resources[] | select('.name' == "master0") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
master_name0=$(jq '.resources[] | select('.name' == "master0") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
minion_ip0=$(jq '.resources[] | select('.name' == "minion0") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
minion_name0=$(jq '.resources[] | select('.name' == "minion0") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
minion_ip1=$(jq '.resources[] | select('.name' == "minion1") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
minion_name1=$(jq '.resources[] | select('.name' == "minion1") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')

cat <<EOF > ansible/inventory/hosts
[all]
$master_name0 ansible_host=$master_ip0 ansible_user=haugom
$minion_name0 ansible_host=$minion_ip0 ansible_user=haugom
$minion_name1 ansible_host=$minion_ip1 ansible_user=haugom

[kubernetes2]
$master_name0
$minion_name0
$minion_name1

[master]
$master_name0

EOF
