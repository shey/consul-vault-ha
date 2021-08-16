# consul-vault-haproxy

Ansible playbooks that install and configure Vault with Consul backend-- behind HAProxy.

## Notes

1. This demo requires `Vagrant` and `VirtualBox`.
1. The consul encryption key is hardcoded in ansible-vault.
1. Initializing and unsealing the vault is a manual step.
1. Vagrant assumes your public key is available at ~/.ssh/id_rsa.pub

## Instructions

### Prepare the env
1. run ```make setup``` to install vagrant-hostmanager and generate the encryption key for Ansible vault.

### Setup a HAProxy loadbalancer
1. run ```ENV=vagrant make build-proxies```

### Prepare hosts to become consul servers
1. run ```make start-vms``` to start vagrant boxes and setup /etc/hosts.
1. run ```ENV=vagrant make build-consul-servers``` to install base packages and consul on the hosts

#### Bootstrapping and clustering Consul
1. run ```ENV=vagrant make bootstrap-consul``` to deploy the bootstrap config to the host and start consul in bootstrapped mode.
1. run ```ENV=vagrant make cluster-consul``` to generate the server configs and have the consul servers join together to form a more perfect union.
1. run ```ENV=vagrant make verify-cluster``` to check consul membership. You should see all three servers listed.

### Setup Consul clients and Vault servers
1. run ```ENV=vagrant make buid-vault-servers```

### Initializing and unsealing vaults

1. On one of the vault machines, run the following command to initialize the vault. Upon initialization, Vault will return the unsealing keys and the master token.

```vault operator init```

1. Each vault requires three keys to unseal. Each vault must be unsealed individually.

```vault unseal <key$>```

## Author and  License
Copyright (c) 2021 Shey Sewani, MIT License

