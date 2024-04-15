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
- Glances can be configured as a web interface or as a data exporter for something like Prometheus
  - Ports
    - Web: 61208
    - Prom: 19091 (or whatever you configure)
  - Flags (these are mutually exclusive...swap flags to switch behavior)
    - Web: -w
    - Prom: --export prometheus

### Glances Password Protection

You can see how to enable it [here](https://glances.readthedocs.io/en/latest/docker.html#how-to-protect-your-dockerized-server-or-web-server-with-a-login-password) but as of 4/15/2024 Option 2 does not work.

Follow the steps for Option 1 and then use the `glances-password.docker-compose.yml` file. Run the commands from the folder containing your `glances.conf` file.

```bash
# Enter container
docker exec -it glances sh

# Generate password file for default login - add the --username password to set the username as well
glances -s --password

# Exit container (CTRL+C a few times) and then type "exit" after you confirm the password and the Announce line appears

# Create secrets directory
mkdir secrets

# Copy the password file to the host
docker cp glances:/root/.config/glances/glances.pwd ./secrets/glances_password
```
