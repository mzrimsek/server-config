# Hoppscotch.io

Hoppscotch is a free, fast and beautiful API request builder (web alternative to Postman)

See instructions on self hosting it here: https://docs.hoppscotch.io/documentation/self-host/community-edition/install-and-build

I have removed some of the unnecessary environment variables for my use case (mostly big tech OIDC providers) so if you make sure to reference the original documentation if you need to add them back.

## Notes

On the initial run you need to do database migrations for the application to spin up.

I added this line to the docker-compose the first time
`entrypoint: ["sh", "-c", "pnpx prisma migrate deploy"]` and then removed it after the migrations completed.
