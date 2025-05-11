# Cloudflared

Cloudflared uses Cloudflare's Zero Trust tunnels to establish secure connections with services and devices within your network. Cloudflare has a ton of options for securing and locking these tunnels down as well.

# Note

When you configure your tunnel in Cloudflare you must ensure that any docker services you are using are ON THE CLOUDFLARED NETWORK and then you must use the CLOUDFLARED NETWORK CONTAINER IP ADDRESS to configure the endpoint. Also make sure to have a SSL cert from Cloudflare to handle SSL proxying for you.