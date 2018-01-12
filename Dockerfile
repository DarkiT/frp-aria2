FROM alpine:latest
MAINTAINER ZiShuo <www@zishuo.uu.me>

ARG FRP_VER=0.14.1
ENV FRP=on

COPY init.sh /init.sh
COPY download.sh /download.sh
COPY tmp/ /etc

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories && \
	apk add --update \
	wget \
	tar \
	aria2 && \
	rm -rf /var/cache/apk/* && \
	chmod +x /download.sh && \
	sh /download.sh && \
	rm -rf /download.sh && \
	chmod +x /usr/local/bin/frpc && \
	chmod +x /init.sh && \
	apk del wget tar && \
	mkdir /config
	
VOLUME /config /downloads

EXPOSE 6800

CMD ["/init.sh"]
