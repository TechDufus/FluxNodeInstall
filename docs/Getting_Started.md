Getting Started
===============

This is a quick guide to get you started with the `FluxNodeInstall` Ansible playbook.

This project is meant to be [FORKED](https://docs.github.com/en/get-started/quickstart/fork-a-repo) and customized to your needs. It is not meant to be run as is.

## Requirements

See the [Requirements](../README.md#requirements) section in the main README.

## Expertise Level

This guide assumes you have a basic understanding of Ansible and the FluxNodeInstall playbook.

For beginners, we recommend you read the [Ansible documentation](https://docs.ansible.com/ansible/latest/index.html) and the [FluxNodeInstall README](../README.md).

## Setup

### Clone the repository

Clone the repository to your local machine:

NOTE: You will need to [FORK](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repository before you can clone it.

```bash
git clone https://github.com/<your_github_username>/FluxNodeInstall.git
```

### Bootstrap Script

The `bootstrap.sh` script will install Ansible and its dependencies on your local machine.

```bash
./scripts/bootstrap.sh
```

### Inventory

The `hosts.ini` file contains the list of hosts that will be targeted by the playbook.

It will be up to you to add the hosts you want to target. There are a few required host variables that you will need to set.

#### Required Host Variables

##### gateway

```ini
gateway # The IP address of the gateway for this node.
```

##### apiport

```ini
apiport # The port that the FluxNode API will listen on. Think of this as the UPnP Api Port.
```

##### user

```ini
user # This is the user in the [user](../user.yml) var file that corresponds with the Zelcore user and collateral information.
    # Example: If you have a user named "zelcore1" in the [user](../user.yml) var file, then you would put "zelcore1" here.
    # user.yml
    # ---
    # user:
    #   zelcore1:
    #     zelid: "12345678901234567890"
    #     identity_key: "1234567890123456789012345678901234567890123456789012345678901234"
    #     [...]
```

##### n

```ini
n # This will correspond to the collateral index created in the [user](../user.yml) var file.
    # Example: If you have a user named "zelcore1" in the [user](../user.yml) var file, and you have a several collateral items, you would put the corresponding one on the host.
    # user.yml
    # ---
    # user:
    #   zelcore1:
    #     zelid: "12345678901234567890"
    #     identity_key: "1234567890123456789012345678901234567890123456789012345678901234"
    #     collat1:
    #       collateral_tx: "1234567890123456789012345678901234567890123456789012345678901234"
    #       [...]
    #     collat2:
    #       collateral_tx: "1234567890123456789012345678901234567890123456789012345678901234"
    #       [...]
    #     [...]
```

##### Example Host Entry

```ini
[all:children]
cumulus

[cumulus]
dufusC1 ansible_host=10.0.0.10 apiport=16127 user=zelcore1 n=collat1
dufusC2 ansible_host=10.0.0.11 apiport=16137 user=zelcore1 n=collat2

[cumulus:vars]
gateway=10.0.0.1
ansible_user=dufus
```

### User Variables

The [user.yml](../user.yml) file contains the list of the required user variables.

### OPTIONAL: Setup script for inventory and user variables

The `setup.sh` script will create the inventory and user variable files for you. After prompting you for the required information, it will create the files and place them in the correct location.

This means it will overwrite any existing files (hosts.ini and user.yml). So if you have already created the files, you will need to back them up before running the script.

```bash
./scripts/setup.sh
```

## Running the Playbook

### Run the playbook

```bash
ansible-playbook flux.yml -t all
```
This will run the entire playbook on all hosts in the inventory and all tasks in the playbook. You can also run specific tasks by using the tags.

### Run specific tasks

```bash
ansible-playbook flux.yml -t <tag>
```

#### Tags

##### all

This tag will run all tasks in the playbook.

##### purge

This tag will run the `purge` task(s) in each role, essentially removing the fluxnode.

##### roles

This is not a tag name, but each role name is a tag. So you can run a specific role by using the role name as the tag.

```bash
ansible-playbook flux.yml -t <role>
```
