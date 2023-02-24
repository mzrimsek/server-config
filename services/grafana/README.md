# Grafana

[Grafana](https://grafana.com/) is a powerful, open source data visualization tool.

This works well with the [system monitoring stack](../../stacks/system-monitoring/). Some basic dashboards for this stack is provided in the `dashboard-templates` folder. Create a new dashboard, edit it, open the JSON view, and paste in the template to apply it.

## Environment Variables

| Variable               | Description                                                                                                 |
| ---------------------- | ----------------------------------------------------------------------------------------------------------- |
| CONFIG_DIR             | Root directory where service configuration files will live                                                  |
| ADMIN_USER             | Admin user username                                                                                         |
| ADMIN_PASSWORD         | Admin user password                                                                                         |
| GRAFANA_URL            | URL that points to the Grafana instance                                                                     |
| AUTHELIA_CLIENT_SECRET | Client secret to enable login with [Authelia](https://www.authelia.com/integration/openid-connect/grafana/) |
| AUTHELIA_URL           | Base URL that points to the Authelia instance                                                               |

## Prometheus Metrics

Add this to your Prometheus config to pull in Grafana metrics for monitoring

```yml
 - job_name: 'grafana'
    scrape_interval: 5s
    static_configs:
      - targets: ['${HOST_IP}:13000']
```
