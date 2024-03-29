Common
=========

An Ansible role to install common packages and configure common settings for FluxNodes.


Requirements
------------

This role requires Ansible 2.0 or higher.

Role Variables
--------------

```yaml
# These are from the vars.yml file and come with defaults
ip:
  url1: # Main url to detect public IP
  url2: # Fallback url in case of primary failure
```

Dependencies
------------

None.

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
