FROM alpine:3.12

ARG CLAM_VERSION=0.102.4-r1
ARG UNAME=clamav
ARG UID=1000
ARG GID=1000
RUN addgroup -g $GID $UNAME
RUN adduser -D -u $UID -G $UNAME $UNAME

RUN apk add --no-cache clamav=$CLAM_VERSION clamav-libunrar=$CLAM_VERSION

RUN mkdir /data && \
    chown -R clamav:clamav /data/ && \
    chown -R clamav:clamav /var/log/clamav

USER $UNAME

COPY run.sh /run.sh
COPY health.sh /health.sh
COPY conf/ /etc/clamav/

RUN freshclam

VOLUME /data/
VOLUME /var/log/clamav/

CMD ["/run.sh"]

EXPOSE 3310
HEALTHCHECK --start-period=15s CMD /health.sh