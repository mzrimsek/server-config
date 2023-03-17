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

Authelia is used as the auth provider for both stacks, but my configuration essentially sets up the `Main` stack authelia middleware to point at `Infrastructure`'s Authelia container. Then configuration is done on the container labels and in the file providers used for host/external services. With this in mind, I've applied the authelia@docker middleware nearly all routes that are handled by reverse proxy - even the ones that will always be set to bypass. The idea here being that if all the routes have the middleware, I can handle access control consistently for all services and all in the one Authelia configuration file.

### Unraid Specific

On occasion the docker.img will fill up (not sure why it should really only hold the docker images). I believe this causes the whole daemon to gradually stop working (the console commands become unresponsive and the tab does not load). So far a simple reboot fixes it, but is not ideal.

Some suggest deleting the docker.img file to try and fix it because it may have become corrupt at some point. If you do this, you will lose all of your running Docker containers because the images will all be gone. Here are some steps:

1. Stop the Docker service in Unraid
2. Click the little checkbox to delete the docker.img file
3. Apply
4. Reenable the Docker service
5. Install Portainer-CE from the community applications
6. Update the Portainer configuration
   1. Rename to 'portainer'
   2. Set port for web ui to 9000
   3. Set the restart policy to 'always'
   4. Add watchtower label (`com.centurylinklabs.watchtower.enable=true`)
7. Login to Portainer at `http://<unraid-ip>:9000`
8. Your stacks and everything should all be intact and you should just have to redeploy them for all the images to pull and the containers be regenerated
