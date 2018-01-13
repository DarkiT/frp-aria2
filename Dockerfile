FROM alpine
MAINTAINER ZiShuo <www@zishuo.uu.me>

ARG FRP_VER=0.14.1
ENV FRP=on

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main" > /etc/apk/repositories && \
	apk add --update \
	wget \
	tar \
	aria2 && \
	rm -rf /var/cache/apk/* && \
	wget  --no-check-certificate -q https://code.aliyun.com/zishuo/config/raw/master/docker/frpc.sh -O /frpc.sh && \
	chmod +x /frpc.sh && \
	sh /frpc.sh && \
	mkdir /config
	
VOLUME /config /downloads

EXPOSE 6800

CMD ["/init.sh"]