FROM alpine:edge

COPY build/supervisord.conf /etc/supervisord.conf
# You can get parser's source from https://github.com/unsacrificed/network-list-parser/
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
  apk --update --no-cache add git wireguard-tools bird py3-setuptools supervisor && \
  wget https://github.com/unsacrificed/network-list-parser/releases/download/v1.2/network-list-parser-linux-amd64-1.2.bin \
  -O /usr/local/bin/parser && \
  rm -f /etc/bird.conf && \
  chmod a+x /usr/local/bin/parser && \
  mkdir /etc/bird/

VOLUME /etc/periodic/
VOLUME /etc/bird
VOLUME /etc/wireguard/

EXPOSE 51820/udp

CMD ["supervisord","-c","/etc/supervisord.conf"]