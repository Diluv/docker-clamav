FROM alpine:3.11

ENV CLAM_VERSION=0.102.1-r0

RUN apk add --no-cache clamav=$CLAM_VERSION clamav-libunrar=$CLAM_VERSION

RUN freshclam

COPY run.sh /run.sh
COPY health.sh /health.sh
COPY conf /etc/clamav

VOLUME /data
VOLUME /var/log/clamav

ENTRYPOINT ["/run.sh"]

EXPOSE 3310
HEALTHCHECK --start-period=60s CMD /health.sh