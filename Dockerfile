FROM alpine:3.11

ENV CLAM_VERSION=0.102.1-r0

RUN apk add --no-cache clamav=$CLAM_VERSION clamav-libunrar=$CLAM_VERSION


COPY conf /etc/clamav
COPY run.sh /run.sh
COPY health.sh /health.sh

EXPOSE 3310/tcp

CMD ["/run.sh"]

VOLUME /data

HEALTHCHECK --start-period=60s CMD /health.sh