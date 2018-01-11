FROM alpine:latest
MAINTAINER ZiShuo <www@zishuo.uu.me>

ENV FRP 'on'
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories
RUN apk add --update \
	aria2 \
	&& rm -rf /var/cache/apk/*

COPY init.sh /init.sh
COPY download.sh /download.sh
RUN chmod +x /download.sh && \
	sh /download.sh
COPY frpc /usr/local/bin/
RUN chmod +x /usr/local/bin/frpc && \
	chmod +x /init.sh && \
	mkdir /config

COPY tmp/ /etc

VOLUME /config /downloads

EXPOSE 6800

CMD ["/init.sh"]