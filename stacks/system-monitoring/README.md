# Monitoring Data Collection

The goal of this stack is to provide data sources for Prometheus and then expose a single Prometheus endpoint per device to then be organized later by a single Grafana instance, as well as a Glances instance to get at a glance system stats.

## Services

- [Prometheus](https://prometheus.io/) - Time series database
- [cAdvisor](https://github.com/google/cadvisor) - Docker container monitoring
- [nodeExporter](https://github.com/prometheus/node_exporter) - System resource monitoring
- [Glances](https://nicolargo.github.io/glances/) - At a glance system monitoring web interface
- [Watchtower](https://containrrr.dev/watchtower/) - Automated container image updates

## Environment Variables

| Variable                         | Description                                                                                                               |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR                       | Root directory where service configuration files will live                                                                |
| WATCHTOWER_NOTIFICATION_PROVIDER | [Shoutrrr](https://containrrr.dev/shoutrrr/v0.5/services/overview/) notification provider                                 |
| WATCHTOWER_NOTIFICATION_URL      | [Shoutrrr](https://containrrr.dev/shoutrrr/v0.5/services/overview/) notification URL to get updates on Watchtower actions |
| WATCHTOWER_UPDATE_INTERVAL       | Value in seconds to wait between checking containers for updates                                                          |
| WATCHTOWER_API_TOKEN             | API Token to send with requests to metric endpoints                                                                       |

## Notes

- For some reason there were permission issues I could not figure out when trying to mount the Prometheus data volume from a directory. Switching to the Docker volume instead works. Seems like there's no negative impact on anything doing it this way.
- Glances here is configured do to Prometheus exports but can also be configured to run with a web interface
  - Ports
    - Web: 61208
    - Prom: 19091 (or whatever you configure)
  - Flags (these are mutually exclusive...swap flags to switch behavior)
    - Web: -w
    - Prom: --export prometheus
