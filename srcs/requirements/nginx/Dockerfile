FROM debian:bookworm

RUN <<eof
apt-get update && \
apt-get dist-upgrade -y && \
apt-get install -y \
	curl \
	wget \
	nginx && \
apt-get clean
eof

COPY conf/ngingx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["ngingx"]
CMD ["-g", "daemon off;"]
