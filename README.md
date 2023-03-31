# WARNING: This project is still in development and is not yet ready for live or production use.

## Ansible project for installing RunOnFlux nodes

This Ansible project aims to replace the current Bash script used for installing RunOnFlux nodes with a more efficient and effective method using Ansible.

### Requirements

- Ansible (version >= v2.14.3)
- Python (version >= v3.10.6)

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
