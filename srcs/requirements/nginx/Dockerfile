FROM debian:bookworm

RUN apt-get update && \
	apt-get dist-upgrade -y && \
	apt-get install -y \
		curl \
		wget \
		nginx \
	apt-get clean

COPY conf/ngingx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["ngingx"]
CMD ["-g", "daemon off;"]
