all:
	mkdir -p /home/rtissera/data/wordpress/ /home/rtissera/data/mariadb/
	docker compose -f srcs/docker-compose.yml up -d --build

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	docker system prune -f -a --volumes
	sudo rm -rf /home/rtissera/data/

re: clean
	make all

.PHONY: down clean re
