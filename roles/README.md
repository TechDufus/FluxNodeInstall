FluxNodeInstall Roles
=====================
This directory contains the roles that are used by the FluxNodeInstall playbook.

Almost all of the config / variables used by these roles are in the [vars](../vars.yml) var file.

The roles are listed below in the order they are run by the playbook.
- [Common Role](common/)
- [UFW Role](ufw/)
- [Docker Role](docker/)
- [NVM Role](nvm/)
- [Mongo Role](mongo/)
- [Daemon Role](daemon/)
- [Log Rotate Role](logrotate/)
- [Fluxbench Role](fluxbench/)
- [FluxOS Role](fluxos/)
- [PM2 Role](pm2/)
- [Watchdog Role](watchdog/)
- [IP Check Role](ipcheck/)

The exception to this is if you are using the `--tags` option to run a specific role. But even then, the roles are run in the order listed above depending on what tags you provide.
