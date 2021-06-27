#!/usr/bin/env bash

master_ip=$(jq '.resources[] | select('.name' == "master") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
master_name=$(jq '.resources[] | select('.name' == "master") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
worker_ip=$(jq '.resources[] | select('.name' == "worker") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
worker_name=$(jq '.resources[] | select('.name' == "worker") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')

master_ip2=$(jq '.resources[] | select('.name' == "master2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
master_name2=$(jq '.resources[] | select('.name' == "master2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
master_ip3=$(jq '.resources[] | select('.name' == "master3") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
master_name3=$(jq '.resources[] | select('.name' == "master3") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
worker_ip2=$(jq '.resources[] | select('.name' == "worker2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
worker_name2=$(jq '.resources[] | select('.name' == "worker2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')


cat <<EOF > ansible/inventory/hosts
[all]
$master_name ansible_host=$master_ip ansible_user=student
$master_name2 ansible_host=$master_ip2 ansible_user=student
$master_name3 ansible_host=$master_ip3 ansible_user=student
$worker_name ansible_host=$worker_ip ansible_user=student
$worker_name2 ansible_host=$worker_ip2 ansible_user=student

[kubernetes]
$master_name
$master_name2
$master_name3
$worker_name
$worker_name2

[master]
$master_name
$master_name2
$master_name3

[worker]
$worker_name
$worker_name2

EOF
