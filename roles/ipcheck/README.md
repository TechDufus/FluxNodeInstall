ipcheck
=========

This role installs the ipcheck script on a node. The ipcheck script is used to check the IP address (public address) of a has changed and updates services accordingly.


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
