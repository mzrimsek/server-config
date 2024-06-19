# paperless-ngx

A PDF processing and management server

## Notes on Deployment

For whatever reason I was having intermittent issues with gateway timeouts using the Traefik labels on my paperless service. I ended up doing a [traefik file provider](../traefik/external_https_file_provider.yaml) to get it to work.

### Using ProtonMail Bridge

https://github.com/shenxn/protonmail-bridge-docker/tree/master?tab=readme-ov-file#initialization

1. Run this commmand to init your data `docker run --rm -it -v paperless-ngx-proton:/root shenxn/protonmail-bridge init`
2. When prompted enter the "login" command and follow the prompts to auth with your account
3. After ths sync in complete, run "info" and note down the username and password.
4. Run the "exit" command to stop the bridge gracefully
5. Exit the container
