# WARNING: This project is still in development and is not yet ready for live or production use. (POWERED BY DUFUS!!!)

## Ansible project for installing RunOnFlux nodes

This Ansible project aims to replace the current Bash script used for installing RunOnFlux nodes with a more efficient and effective method using Ansible.

### Requirements

- Ansible (version >= v2.14.3)
- Python (version >= v3.10.6)
- Ubuntu (version >= v22.04)
  - You may need Ubuntu 22.04 or later to install Ansible v2.14.3 or later.


### Prerequisites

#### 1. Ansible Galaxy Modules
You will need to run the following command to install the Ansible Galaxy modules used in this project:

```bash
ansible-galaxy install -r requirements.yml
```

#### 2. `user.yml` file with filled in variables
You will need to create a user.yml file with the variables filled in. You can use the user.yml file as a template.

If you want to use the script to generate a user.yml file for you, you can run the following command:
```bash
./scripts/setup.sh
```
This will generate a user.yml file that you will need to move to the root of the project.

```bash
mv ./scripts/user.yml user.yml -f
```


### Usage

1. Clone this repository onto the Ansible control node.
2. Create an inventory file with the IP addresses of the nodes you want to install RunOnFlux onto.
3. Run the ansible-playbook command passing in the inventory file and the playbook file.

```bash
ansible-playbook -i inventory.ini playbook.yml
```

### Playbook Contents

- **vars**: contains variables such as package names and version numbers needed to install RunOnFlux.
- **tasks**: contains the tasks needed to install and configure RunOnFlux.
- **handlers**: contains handlers for when certain tasks are executed.
- **templates**: contains configuration files necessary for RunOnFlux.

### Contributing

Please feel free to contribute to this project by submitting issues and/or pull requests.

### Authors

- [TechDufus](https://github.com/techdufus)
- [MattConres](https://github.com/mattconres)
- [JKTUNING](https://github.com/jktuning)

### License

This project is licensed under the [MIT License](https://github.com/TechDufus/FluxNodeInstall/blob/main/LICENSE).
