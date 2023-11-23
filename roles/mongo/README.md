mongo
=========

This role installs MongoDB and it's configuration on a node.


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

mongo:
  keyring: # Keyring file path for APT
  path4: # Path to MongoDB 4.4 APT key
  list4: # Path to MongoDB 4.4 APT source list
  path6: # Path to MongoDB 6.0 APT key
  list6: # Path to MongoDB 6.0 APT source list
  path7: # Path to MongoDB 7.0 APT key
  list7: # Path to MongoDB 7.0 APT source list
  mongo4:
  # packages takes a list of dictionaries with the following keys:
    packages:
      - name: # MongoDB-related package name to install
        version: # MongoDB-related package version to install
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

