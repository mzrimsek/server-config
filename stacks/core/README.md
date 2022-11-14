# Core

I have services set up on multiple devices in my network that have different roles. The main evolution I tried to get to from this setup is being able to handle all my routing for both servers that run Docker containers with Traefik labels. That means running Traefik on all devices and routing to containers from there. Getting this setup was a bit of a headache, but it's possible to add a file provider to pass traffic from one Traefik instance to the next while letting all of our normal Traefik configurations sit the way we are used to.

An example file provider to route to the other Traefik instance is provided. Essentially you set up on service that routes to one of your entry points in your secondary Traefik instance and then configure routers for each subdomain you want to route to that instance and associate it with that service. From there the secondary Traefik instance can take over routing and handling SSL certs.

## Infrastructure

Represents the services configured on the NAS, mostly revolving around file manipulation, network configuration, databases, and more that just kinda chill in the background and get consumed by other services I actually interface with more.

## Main

Represents the services configured on my main server (or at least part of it). These are usually my daily driver services and game servers.

## Notes

Sometimes services are deployed in both stacks because they serve some kind of ubiquitous utility or tool.

- Traefik - Container label based reverse proxy configuration. Makes routing to services much easier to configure.
- Duplicati - Remote file backup. It's convenient to be able to directly backup files off the machine without it being dependent on another device (main server does not need to go to the NAS to get its backup done)
- Watchtower - Automated container image updates. Kind of self explanatory - I don't let things like the reverse proxy or VPN client auto update because they are too critical to the underlying architecture.
