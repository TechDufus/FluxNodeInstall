fluxbench
=========

This role `only` configures fluxbench and performs no installation actions.

Requirements
------------

See [README.md Requirements](../../README.md#requirements).

Role Variables
--------------

None. See Dependencies for information on the variables that are used.

Dependencies
------------

This role depends on the [daemon](../daemon/README.md) has installed fluxbench

```yaml
fluxbench:
  dir: # The directory to deploy fluxbench config files to
  conf_file: # The path to the fluxbench config file
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
