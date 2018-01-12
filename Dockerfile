FROM alpine:latest
MAINTAINER ZiShuo <www@zishuo.uu.me>

ENV FRP 'on'
RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories
RUN apk add --update \
	wget \
	tar \
	aria2 \
	&& rm -rf /var/cache/apk/*

COPY init.sh /init.sh && \
	download.sh /download.sh && \
	tmp/ /etc

RUN chmod +x /download.sh && \
	sh /download.sh && \
	rm -rf /download.sh && \
	chmod +x /usr/local/bin/frpc && \
	chmod +x /init.sh && \
	apk del wget tar && \
	mkdir /config
	
VOLUME /config /downloads

EXPOSE 6800

CMD ["/init.sh"]
