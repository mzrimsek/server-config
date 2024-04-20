#bin/sh

docker exec authelia-redis sh -c "chown -R redis:redis /etc/crontabs && chown -R redis:redis /data"
