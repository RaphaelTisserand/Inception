all:
	mkdir -p /home/snaji/data/wordpress/ /home/snaji/data/mariadb/
	docker compose -f srcs/docker-compose.yml up

down:
	docker compose -f srcs/docker-compose.yml down

clean: down
	sudo rm -rf /home/snaji/data/wordpress/ /home/snaji/data/mariadb/

re: clean
	make all
