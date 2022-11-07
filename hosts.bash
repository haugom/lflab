#!/usr/bin/env bash

master_ip=$(jq '.resources[] | select('.name' == "master") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
master_name=$(jq '.resources[] | select('.name' == "master") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
worker_ip=$(jq '.resources[] | select('.name' == "worker") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
worker_name=$(jq '.resources[] | select('.name' == "worker") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')

#master_ip2=$(jq '.resources[] | select('.name' == "master2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
#master_name2=$(jq '.resources[] | select('.name' == "master2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
#master_ip3=$(jq '.resources[] | select('.name' == "master3") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
#master_name3=$(jq '.resources[] | select('.name' == "master3") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
worker_ip2=$(jq '.resources[] | select('.name' == "worker2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
worker_name2=$(jq '.resources[] | select('.name' == "worker2") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')

#cp_ip=$(jq '.resources[] | select('.name' == "cp") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
#cp_name=$(jq '.resources[] | select('.name' == "cp") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')
#lab_worker_ip=$(jq '.resources[] | select('.name' == "worker-lab") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.ip')
#lab_worker_name=$(jq '.resources[] | select('.name' == "worker-lab") | {ip: .instances[0].attributes.network_interface[0].access_config[0].nat_ip, name: .instances[0].attributes.name}' terraform.tfstate  | jq -r '.name')


cat <<EOF > ansible/inventory/hosts
[all]
$master_name ansible_host=$master_ip ansible_user=haugom
#$master_name2 ansible_host=$master_ip2 ansible_user=haugom
#$master_name3 ansible_host=$master_ip3 ansible_user=haugom
$worker_name ansible_host=$worker_ip ansible_user=haugom
$worker_name2 ansible_host=$worker_ip2 ansible_user=haugom
#$cp_name ansible_host=$cp_ip ansible_user=haugom
#$lab_worker_name ansible_host=$lab_worker_ip ansible_user=haugom

[kubernetes]
$master_name
#$master_name2
#$master_name3
$worker_name
$worker_name2

[kubernetes2]
#$cp_name
#$lab_worker_name

[master]
$master_name
#$master_name2
#$master_name3

[worker]
$worker_name
$worker_name2

EOF
