# GPN Stack with Docker

This project aims to be a simple and easy-start implementation
of the Grafana-Prometheus-Netdata monitoring stack.
It implements every component by creating a docker container
from the corresponding image.

## Getting up and running
Only three commands are needed in order to get up and running:
```
$ git clone https://github.com/PhilsLab/gpn-docker
$ cd gpn-docker
$ docker-compose up -d
```

Please make sure that `docker` and `docker-compose` are installed,
and that you have access to the docker daemon.
If you are member of the docker group, you are fine.
If not, please run
```
$ sudo usermod -aG docker $(whoami)
$ newgrp docker
```
to add your own user to the docker group and log in to the group
afterwards. If you don't want to add your user to the docker group,
you will have to execute every command as root via `sudo`.

## Volumes / Storage
All data is kept in subdirectories of `./data/` via docker
bind-volumes. This makes the entire stack, including it's data,
not only easy to reset to it's initial state, but also easy
to archive.

## Components and their sane defaults
### Grafana
* Administrator login
  * Default user: `system`
  * Default password: `gpn`
* Anonymous login
  * Anonymous access is enabled.
  * Without authentication, you are granted Editor permissions so 
    you can create dashboards and play around in the "Explore" tab.
* Explore tab
  * Explore tab is enabled.
  * This enables you to play around with prometheus metrics, without
    having to create a dashboard.
* Provisioning
  * The Prometheus datasource is added automatically.
  * A few beautiful dashboards are provided for your convenience:
    * Netdata Machine Overview
    * Netdata CPU Drilldown
* Analytics
  * Grafana analytics / telemetry is disabled for better privacy.

### Prometheus
Prometheus is configured to automatically pick up metrics generated
by Netdata. The scrape interval is set to __5 seconds__.
As an addition, the port portion of the instance name gets removed
via relabeling for cosmetic reasons.

### Netdata
Netdata configuration is minimal. Metrics are only kept in memory,
and are not cached on disk. Retention is set to __600 samples__,
and samples are collected __every second__.
Most plugins, and also Netdata registry are disabled.
