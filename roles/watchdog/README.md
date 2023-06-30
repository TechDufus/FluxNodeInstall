watchdog
=========

Install and configure watchdog.

Requirements
------------

See [README.md Requirements](../../README.md#requirements).

Role Variables
--------------

None. See Dependencies for information on the variables that are used.

Dependencies
------------

```yaml
global:
  user: # Flux user for the node.

watchdog:
  path:  # Path to watchdog directory
  repo:  # Repo to clone
  hooks: # GitHub hooks file
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

