# Export Fail2Ban Prometheus Metrics

Use the provided Docker compose file to spin up an instance of a Fail2Ban exporter to get metrics to import into Prometheus.

Add this to your Prometheus config to add the new target

```yml
 - job_name: 'fail2ban'
    scrape_interval: 5s
    static_configs:
      - targets: ['${HOST_IP}:9191']
```
