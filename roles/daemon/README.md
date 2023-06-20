Daemon
=========

This role installs and configures the Flux daemon, sysbench, and the bootstrap.


Requirements
------------

See [README.md Requirements](../../README.md#requirements).

[//]: # (This role requires Ansible 2.0 or higher.)

Role Variables
--------------

None. See Dependencies for information on the variables that are used.

Dependencies
------------

```yaml
# These are from the vars.yml file and come with defaults
daemon:
  bootstrap_url: # The URL to the bootstrap file
  path: # The path to download the bootstrap file to
  config: # The path to the config file for the daemon
  keyring: # The full path to the keyring file for apt
  list_file: # The full path to the list file for apt
  service_name: # The name of the service for the daemon
  rpcport: # The port for the daemon to listen on
  port: # The port for the  to listen on
  fluxbench_file: # The path to the fluxbench config file

global:
  user: # The Flux user
```

Example Playbook
----------------

See [flux.yml](../../flux.yml).

License
-------

MIT

Author Information
------------------

This role was created in 2023 by [TechDufus](https://github.com/techdufus).

Please feel free to create a pull request or open an issue if you find any problems.

See [CONTRIBUTING.md](../../.github/CONTRIBUTING.md) for information on contributing.
