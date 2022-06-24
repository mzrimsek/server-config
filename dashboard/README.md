# Dashboard

[This dashboard](https://github.com/phntxx/dashboard) is an easily customizable, themable, and configurable webpage to organize all your services and frequently accessed bookmarks.

- Data: Requires a volume to hold configurations, mounted as a volume to `app/data`

The provided update script would need some minor tweaks to update from the correct repositories, but has proven useful in updating the container quickly after changes are made.I was ultimately able to set up an n8n workflow to watch for updates to the config files to programmatically run the update script.