Docker
=========

This role installs docker and its accompanied configuration.

This configuration includes:
- Installing the following packages:
  - docker-ce
  - docker-ce-cli
  - containerd.io
- Creating the docker group if it does not exist
- Adding the user to the docker group
- Starting the docker service

Requirements
------------

See [README.md Requirements](../../README.md#requirements).

Role Variables
--------------

None. See Dependencies for information on the variables that are used.

Dependencies
------------

```yaml
docker:
  keyring: # The full path to the keyring file for apt
  list_file: # The full path to the list file for apt
```

Example Playbook
----------------

See [main.yml](../../main.yml).

License
-------

MIT

Author Information
------------------

This role was created in 2023 by [TechDufus](https://github.com/techdufus).

Please feel free to create a pull request or open an issue if you find any problems.

See [CONTRIBUTING.md](../../.github/CONTRIBUTING.md) for information on contributing.
