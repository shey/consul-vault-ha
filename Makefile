setup:
	vagrant plugin install vagrant-hostmanager
	echo "password" >> password_file

consul-key:
	openssl rand -base64 16

start-vms:
	vagrant up && vagrant hostmanager

destroy-vms:
	vagrant destroy consul01 consul02 consul03
	vagrant destroy vault01 vault02 vault03

build-consul-servers:
	ansible-playbook -i inventory/$(ENV) playbooks/build-consul-servers.yml

bootstrap-consul:
	ansible-playbook -i inventory/$(ENV) playbooks/bootstrap-consul.yml

cluster-consul:
	ansible-playbook -i inventory/$(ENV) playbooks/configure-consul-cluster.yml

verify-cluster:
	ansible -i inventory/$(ENV) bootstrap  -a "consul members"

build-vault-servers:
	ansible-playbook -i inventory/$(ENV) playbooks/build-vault-servers.yml

build-proxies:
	ansible-playbook -i inventory/$(ENV) playbooks/build-haproxy.yml -v

edit-ansible-vault:
	ansible-vault edit inventory/group_vars/$(ENV)/vault.yml

view-ansible-vault:
	ansible-vault view inventory/group_vars/$(ENV)/vault.yml
