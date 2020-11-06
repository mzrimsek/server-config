# server-config
A repo of files to set up my local server

## Networking

Set up SSL certs for the domain that points to the server, as well as an Nginx reverse proxy to route requests to each server.

Used the following posts to assist:

* https://medium.com/faun/docker-letsencrypt-dns-validation-75ba8c08a0d

* https://www.freecodecamp.org/news/docker-nginx-letsencrypt-easy-secure-reverse-proxy-40165ba3aee2

### Notes

* Nginx was kind of a pain. For whatever reason mounting a volume to `etc/nginx` in the container did not allow the container to create the necessary config files. Work around was to not bind the volume until after the container spun up once to allow the files to generate, then use `docker cp` to copy the files from the container to the host in the directory that was then bound to the volume.

* When adding a new nginx site conf, if that site is running in a docker container, the proxy_pass ip address needs to match the address of the network that container is running on.