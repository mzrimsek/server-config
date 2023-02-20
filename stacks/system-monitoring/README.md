# Monitoring Data Collection

The goal of this stack is to provide data sources for Prometheus and then expose a single Prometheus endpoint per device to then be organized later by a single Grafana instance, as well as a Glances instance to get at a glance system stats.

## Services

- Prometheus - Time series database
- cAdvisor - Docker container monitoring
- nodeExporter - System resource monitoring
- Glances - At a glance system monitoring web interface

## Environment Variables

| Variable   | Description                                                |
| ---------- | ---------------------------------------------------------- |
| CONFIG_DIR | Root directory where service configuration files will live |

## Notes

- For some reason there were permission issues I could not figure out when trying to mount the Prometheus data volume from a directory. Switching to the Docker volume instead works. Seems like there's no negative impact on anything doing it this way.
