#!/usr/bin/env bash

master_ip=$(jq '.resources[] | select('.name' == "master") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
master_name=$(jq '.resources[] | select('.name' == "master") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
worker_ip=$(jq '.resources[] | select('.name' == "worker") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
worker_name=$(jq '.resources[] | select('.name' == "worker") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')

cat <<EOF > ansible/inventory/hosts
[all]
$master_name ansible_host=$master_ip ansible_user=student
$worker_name ansible_host=$worker_ip ansible_user=student

[kubernetes]
$master_name
$worker_name

[master]
$master_name

[worker]
$worker_name

EOF
