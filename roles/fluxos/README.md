fluxos (Flux OS)
=========

Install FluxOS codebase and configure

Requirements
------------


Requirements
------------

This role requires the following packages to be installed on the Flux Node:
- NodeJS
- NPM
- NVM
- PM2

These packages are installed by the [common](../common) role.

See [README.md Requirements](../../README.md#requirements).j

Role Variables
--------------

None. See Dependencies for information on the variables that are used.

Dependencies
------------

```yaml
# These vars live in the main vars.yml
flux_os:
  path:        # Path to install FluxOS to
  development: # Whether to install the development version of FluxOS
  testnet:     # Whether to install the testnet version of FluxOS
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
