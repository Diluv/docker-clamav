FROM alpine:3.11

RUN apk add --no-cache clamav clamav-libunrar wget

RUN mkdir /data && \
    chown -R clamav:clamav /data/

COPY conf /etc/clamav
COPY run.sh /run.sh
COPY health.sh /health.sh

EXPOSE 3310/tcp

CMD ["/run.sh"]

HEALTHCHECK --start-period=60s CMD /health.sh