FROM alpine:latest
MAINTAINER ZiShuo <www@zishuo.uu.me>

RUN apk add --update \
	aria2 \
	supervisor \
	&& rm -rf /var/cache/apk/*

COPY init.sh /init.sh
COPY frpc /usr/local/bin/
RUN chmod +x /usr/local/bin/frpc && \
	chmod +x /init.sh && \
	mkdir /config && \
	mkdir -p /var/log/supervisor

COPY tmp/frpc.ini.default /config/frpc.ini.default
COPY tmp/aria2.conf.default /config/aria2.conf
COPY tmp/supervisord.conf /config/supervisord.conf 

VOLUME /config /downloads

EXPOSE 6800

CMD ["/init.sh"]